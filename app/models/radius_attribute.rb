class RadiusAttribute
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :name

  property :name
  property :description

  timestamps!

  validates :name, :presence => true
end
