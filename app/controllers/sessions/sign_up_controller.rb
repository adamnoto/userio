class Sessions::SignUpController < Sessions::BaseController
  before_action :redirect_if_signed_in!

  def new
    @resource = User.new
  end

  def create
    @resource = User.new permitted_params

    if @resource.valid?
      @resource.save!
      UserMailer.welcome_email.deliver_now
      setup_cookies_for_user @resource
      redirect_if_signed_in!
    else
      flash[:alert] = @resource.errors.full_messages.join(". ")
      render "new"
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:email, :password, :confirmation_password)
    end

end
