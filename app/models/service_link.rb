class RadiusReply
  include CouchRest::CastedModel
  include CouchRest::Validation

  property :name
  property :value

  validates :name, :presence => true
  validates :value, :presence => true
end

class ServiceProperty
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
  property :service_properties, [ServiceProperty], :default => []
  property :radius_replies, [RadiusReply], :default => []

  timestamps!

  validates :account, :presence => true
  validates :service, :presence => true
  validates :plan, :presence => true

  after_create :perform_charges

  def self.by_account(account)
    view(:by_account, :key => account)
  end

  def title
    plan = Plan.by_name(self.plan)
    service = Service.by_name(self.service)
    "#{service.title} - #{plan.name}"
  end

  private

  def perform_charges
    plan = Plan.by_name(self.plan)
    if plan.initiation_fee > 0
      Transaction.create!(:account => self.account,
                          :amount => plan.initiation_fee,
                          :code => Transaction::Type::WITHDRAW,
                          :comment => "Initiation charges")
    end
  end

end
