class Admin::DashboardController < AdminController
  def home
    @title = "Home"
    @total_acc = Account.count
  end

  def users
    @title = "Users"
    @q = Account.ransack(params[:q])
    @pagy, @accounts = pagy(@q.result(distinct: true).includes(avatar_attachment: :blob).order(id: :desc), items: 8)
    # @pagy, @accounts = pagy(Account.includes(avatar_attachment: :blob).order(id: :desc), items: 8)
  end

  def masquerade_as_account
    account = Account.find(params[:id])

    # Store the current user's ID in the session
    session[:masquerade_user_id] = current_user.id

    sign_in(account)
    
    redirect_to account_dashboard_path
    flash[:notice] = "Masquerading as #{account.email}"
  end

  def show
    @account = Account.find(params[:id])
    @title = "#{@account.first_name.presence || @account.username}'s profile"
  end

  def destroy
    @account = Account.find(params[:id])
    if @account.present?
      @account.destroy
      redirect_to admin_users_path, notice: "Account Deleted successfully!"
    end
  end
end
