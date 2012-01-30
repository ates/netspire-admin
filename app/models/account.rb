class Account
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :login

  property :login, String
  property :encrypted_password, String
  property :first_name, String
  property :last_name, String

  timestamps!

  validates :login, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def balance
    Transaction.by_account(self.id)["rows"].map(&:values).flatten[1]
  end

  def deposit(amount)
    Transaction.create!(:account => self.id, :amount => amount,
                        :code => Transaction::Type::DEPOSIT)
  end

  def withdraw(amount)
    Transaction.create!(:account => self.id, :amount => (- amount),
                        :code => Transaction::Type::WITHDRAW)
  end

  def self.find_for_authentication(conditions)
    view(:by_login, :key => conditions[:login], :limit => 1).first
  end
end
