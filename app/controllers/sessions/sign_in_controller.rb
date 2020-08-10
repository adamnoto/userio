class Sessions::SignInController < Sessions::BaseController
  before_action :redirect_if_signed_in!

  def new
  end

  def create
    email, password = permitted_params[:email], permitted_params[:password]
    @user = User.find_by_email(email)

    if @user&.valid_password? password
      setup_cookies_for_user @user
      redirect_to profile_path, notice: "Signed in successfully"
    else
      flash[:alert] = "Invalid credentials"
      render "new"
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:email, :password)
    end

end
