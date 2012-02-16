class Private::RadiusAttributesController < PrivateController
  respond_to :html

  def index
    @radius_attributes = RadiusAttribute.all.paginate(:page => params[:page])
  end

  def new
    @radius_attribute = RadiusAttribute.new
  end

  def edit
    @radius_attribute = RadiusAttribute.get(params[:id])
  end

  def create
    @radius_attribute = RadiusAttribute.new(params[:radius_attribute])
    @radius_attribute.save!
    redirect_to(private_radius_attributes_path)
  end

  def update
    @radius_attribute = RadiusAttribute.get(params[:id])
    @radius_attribute.attributes = params[:radius_attribute]
    @radius_attribute.save!
    redirect_to(edit_private_radius_attribute_url(@radius_attribute))
  end

  protected

  def handle_record_invalid
    respond_with(@radius_attribute) do |format|
      format.html do
        action = "new"
        action = "edit" unless @radius_attribute.new?
        render :action => action
      end
    end
  end
end
