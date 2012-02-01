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

  def code
    Type.from_value(self[:code])
  end

  def self.balance_by_account(id)
    view(:balance_by_account, { :key => id, :reduce => true })
  end
end
