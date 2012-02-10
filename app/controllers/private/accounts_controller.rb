class Private::AccountsController < PrivateController
  respond_to :html, :json

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.get(params[:id])
  end

  def create
    @account = Account.new(params[:account])
    @account.save!
    flash[:notice] = "Account was created"
    redirect_to(private_accounts_path)
  end

  def update
    @account = Account.get(params[:id])
    @account.attributes = params[:account]
    @account.save!
    flash[:notice] = "Account was updated"
    redirect_to(edit_private_account_url(@account))
  end

  def transactions
    @transactions = Transaction.by_login(params[:id])
  end

  protected

  def handle_record_invalid
    respond_with(@account) do |format|
      format.html do
        action = "new"
        action = "edit" unless @account.new?
        render :action => action
      end
    end
  end
end
