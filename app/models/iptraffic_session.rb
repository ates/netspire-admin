class IptrafficSession
  include CouchRest::ExtendedDocument

  property :account
  property :sid
  property :ip
  property :octets_in, Integer
  property :octets_out, Integer
  property :amount, Decimal
  property :started_at, DateTime
  property :finished_at, DateTime
  property :updated_at, DateTime
  property :expired, Boolean
end
