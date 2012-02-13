require "devise_token_shim"

class Admin
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  devise :database_authenticatable, :timeoutable, :token_authenticatable

  include Devise::Models::Authenticatable::Shim

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
    if conditions[:authentication_token]
      view(:by_authentication_token,
           :key => conditions[:authentication_token], :limit => 1).first
    else
      view(:by_login, :key => conditions[:login], :limit => 1).first
    end
  end
end
