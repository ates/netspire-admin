class Transaction
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  class Type < Enum
    option :DEPOSIT,  0
    option :WITHDRAW, 1
  end

  property :account, String
  property :amount, Float
  property :code, Integer
  property :comment, String

  timestamps!

  validates :account, :presence => true
  validates :amount, :presence => true, :numericality => true
  validates :code, :inclusion => { :in => Type.values }

  def code
    Type.from_value(self[:code])
  end

  def self.by_account(id)
    view(:by_account, :key => id)
  end
end
