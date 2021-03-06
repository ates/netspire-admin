class Transaction
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  class Type < Enum
    option :DEPOSIT,  0
    option :WITHDRAW, 1
  end

  property :account
  property :service
  property :amount, Float
  property :code, Integer
  property :comment

  timestamps!

  validates :account, :presence => true
  validates :amount, :presence => true, :numericality => true
  validates :code, :inclusion => { :in => Type.values }

  before_save :assert_valid_amount

  def code
    Type.from_value(self[:code])
  end

  def self.balance_by_account(id)
    view(:balance_by_account, { :key => id, :reduce => true })
  end

  def self.by_login(id)
    view(:by_login, :key => id, :descending => true)
  end

  private

  def assert_valid_amount
    raise ArgumentError, "Argument must be greater than zero" unless self.amount > 0
  end
end
