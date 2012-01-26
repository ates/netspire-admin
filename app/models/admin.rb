class Admin
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  devise :database_authenticatable, :timeoutable, :token_authenticatable

  unique_id :login

  property :login, String
  property :encrypted_password, String
  property :authentication_token, String

  timestamps!

  validates :login, :presence => true

  before_save :ensure_authentication_token

  def self.by_authentication_token(options = {})
    view(:by_authentication_token, options)
  end

  def self.find_for_authentication(conditions)
    view(:by_login, :key => conditions[:login], :limit => 1).first
  end
end
