class Transaction
  include CouchRest::CastedModel
  include CouchRest::Validation

  class Type < Enum
    option :DEPOSIT,  0
    option :WITHDRAW, 1
  end

  property :amount, Float
  property :code, Integer
  property :comment, String
  property :created_at, DateTime

  validates :amount, :presence => true

  def code
    Type.from_value(self[:code])
  end
end
