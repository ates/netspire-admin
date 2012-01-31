class Plan
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :name

  property :name, String
  property :title, String

  timestamps!

  validates :name, :presence => true
  validates :title, :presence => true
end
