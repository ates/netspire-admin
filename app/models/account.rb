class Account
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :login

  property :login, String
  property :encrypted_password, String
  property :first_name, String
  property :last_name, String
  property :transactions, [Transaction], :default => []

  timestamps!

  validates :login, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def balance
    balance = 0
    self.transactions.each do |t|
      balance += t.amount
    end
    balance
  end

  def deposit(amount)
    self.transactions << Transaction.new(:amount => amount,
                                         :code => Transaction::Type::DEPOSIT,
                                         :created_at => Time.now.utc)
    save!
  end

  def withdraw(amount)
    self.transactions << Transaction.new(:amount => (- amount),
                                         :code => Transaction::Type::WITHDRAW,
                                         :created_at => Time.now.utc)
    save!
  end

  def self.by_login(options = {})
    view(:by_login, options)
  end

  def self.find_for_authentication(conditions)
    view(:by_login, :id => conditions[:login], :limit => 1).first
  end
end
