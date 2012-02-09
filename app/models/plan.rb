class Plan
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :name

  property :name # Short name for use inside billing
  property :title # Human readable name for present to customers
  property :service # The name of service to which that plan is related
  property :description # Detailed description of plan
  property :active, Boolean, :default => true # Indicates if plan is available

  # Indicates if plan is disabled for new subscription
  property :legacy, Boolean, :default => false

  # Plan will be blocked (marked as inactive) and
  # unavailable after this date
  property :exprires_at, DateTime

  # These are one time charges which can be taken
  # from the customer as a part of installation, activation,
  # service or initiating a connection
  property :initiation_fee, Decimal, :default => 0

  # These are the charges which can be applied based on billing cycle basis
  # as a rental of the product and service provided
  property :periodic_fee, Decimal, :default => 0

  # These are the charges which can be applied on
  # termination of the product and service
  property :termination_fee, Decimal, :default => 0

  # These are the charges which can be applied
  # if a product is suspended because of some reason,
  # for example non-payment
  property :suspention_fee, Decimal, :default => 0

  # There could be a requirement to charge a customer
  # periodically even if a customer is suspended because of some reason
  property:suspention_periodic_fee, Decimal, :default => 0

  # Assuming a product was suspended due to some reason
  # and now it needs it's activation.
  # An operator can apply re-activation charges for this service
  property :reactivation_fee, Decimal, :default => 0

  timestamps!

  validates :name, :presence => true
  validates :title, :presence => true
  validates :service, :presence => true

  def self.by_name(name)
    view(:by_name, :key => name, :limit => 1).first
  end
end
