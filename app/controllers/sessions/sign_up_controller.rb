class Sessions::SignUpController < Sessions::BaseController
  def new
    @resource = User.new
  end

  def create
    @resource = User.new permitted_params

    unless @resource.valid?
      flash[:alert] = @resource.errors.full_messages.join(". ")
      render "new"
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:email, :password)
    end

end
