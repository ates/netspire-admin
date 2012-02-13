class RadiusAttribute
  include CouchRest::ExtendedDocument
  include CouchRest::Validation

  unique_id :name

  property :name
  property :description

  timestamps!

  validates :name, :presence => true

  before_destroy :remove_from_service_links

  private

  def remove_from_service_links
    ServiceLink.all.each do |link|
      link.radius_replies.delete_if {|reply| reply.name == self.name}
      link.save!
    end
  end
end
