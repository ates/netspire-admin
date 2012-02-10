class Account
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  devise :database_authenticatable, :timeoutable

  unique_id :login

  property :login
  property :encrypted_password
  property :first_name
  property :last_name
  property :active, Boolean, :default => true

  timestamps!

  validates :login, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def balance
    Transaction.balance_by_account(self.id)["rows"].map(&:values).flatten[1]
  end

  def deposit(amount)
    Transaction.create!(:account => self.id, :amount => amount,
                        :code => Transaction::Type::DEPOSIT)
  end

  def withdraw(amount)
    Transaction.create!(:account => self.id, :amount => amount,
                        :code => Transaction::Type::WITHDRAW)
  end

  def self.by_login(login)
    view(:by_login, :key => login, :limit => 1).first
  end

  def self.find_for_authentication(conditions)
    view(:by_login, :key => conditions[:login], :limit => 1).first
  end
end
