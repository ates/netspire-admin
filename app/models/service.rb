class Service
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :name

  property :name
  property :title
  property :active, Boolean, :default => true
  property :options, [String], :default => []

  timestamps!

  validates :name, :presence => true, :format => { :with => /^[a-z\d_]+$/ }
  validates :title, :presence => true
  validates :active, :inclusion => { :in => [true, false] }

  def self.by_name(name)
    view(:by_name, :key => name, :limit => 1).first
  end
end
