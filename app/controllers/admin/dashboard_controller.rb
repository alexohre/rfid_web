class Admin::DashboardController < AdminController
  def home
    @title = "Home"
    @total_acc = Account.count
    @total_lec = Lecturer.count
    @total_fac = Faculty.count
    @total_dep = Department.count
  end

  def student_pending
    @title = "Pending Students"
    @q = Account.where(status: :pending).ransack(params[:q]) # Fetch accounts where verification_status is pending
    @pagy, @pending_accounts = pagy(@q.result(distinct: true).includes(avatar_attachment: :blob).order(id: :desc), items: 8)
  end

  def student_verified
    @title = "Verified Students"
    @q = Account.where(status: :verified).ransack(params[:q]) # Fetch accounts where verification_status is verified
    @pagy, @verified_accounts = pagy(@q.result(distinct: true).includes(avatar_attachment: :blob).order(id: :desc), items: 8)
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

  def update_student
    @account = Account.find(params[:id])

    if @account.update(account_params)
      redirect_to admin_path(@account), notice: "Student Details Updated!"
    else
      redirect_to admin_path(@account), alert: "Oops, Something went wrong!"
    end
  end

  def update_student_status
    @account = Account.find(params[:id])
    
    if @account.update(status: "verified")
      redirect_to admin_path(@account), notice: "Account successfully verified!"
    else
      redirect_to admin_path(@account), alert: "Failed to verify account. Please try again."
    end
  end

  def destroy
    @account = Account.find(params[:id])
    if @account.present?
      @account.destroy
      redirect_to admin_users_path, notice: "Account Deleted successfully!"
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :first_name, :last_name, :other_name, :email, :username, :mat_no, :tag_id, :phone_number,
      :address, :state, :zip_code, :country, :date_of_birth, :gender, :faculty_id,
      :department_id
    )
  end
end
