class Private::ServicesController < PrivateController
  respond_to :html

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def edit
    @service = Service.get(params[:id])
  end
  
  def create
    @service = Service.new(params[:service])
    @service.save!
    flash[:notice] = "Service was created"
    redirect_to(private_services_path)
  end

  def update
    @service = Service.get(params[:id])
    @service.attributes = params[:service]
    @service.save!
    flash[:notice] = "Service was updated"
    redirect_to(edit_private_service_url(@service))
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    flash[:notice] = "Service was deleted"
    redirect_to(private_services_url)
  end

  protected

  def handle_record_invalid
    respond_with(@service) do |format|
      format.html do
        action = "new"
        action = "edit" unless @service.new_record?
        render :action => action
      end
    end
  end
end
