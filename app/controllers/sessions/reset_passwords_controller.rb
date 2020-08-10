class Sessions::ResetPasswordsController < Sessions::BaseController
  def show
    if token.nil? || !token.active?
      return redirect_to sessions_reset_token_path,
        alert: "Cannot reset a password using this link. Please request a new link."
    end

    @user = token.user
  end

  def update
    @user = token.user

    if @user.update permitted_params
      redirect_to sessions_sign_in_path, notice: "Now you may sign in with the new password"
      # normally, we should invalidate the token, but it's not strictly on the requiremen
      # so to keep the project much simpler, it's left out
    else
      flash[:alert] = @user.errors.full_messages.join(". ")
      render "show"
    end
  end

  private

    def token
      @token ||= PasswordResetToken.find_by_token params[:reset_password_id]
    end

    def permitted_params
      params.require(:user).permit(:password)
    end

end
