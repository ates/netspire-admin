class RadiusReply
  include CouchRest::CastedModel
  include CouchRest::Validation

  property :name
  property :value

  validates :name, :presence => true
  validates :value, :presence => true
end

class ServiceLink
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  property :account
  property :service
  property :plan
  property :login
  property :password
  property :radius_replies, [RadiusReply], :default => []

  timestamps!

  validates :account, :presence => true
  validates :service, :presence => true
  validates :plan, :presence => true
  validates :login, :presence => true
  validates :password, :presence => true
end
