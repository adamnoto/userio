class Sessions::ResetPasswordsController < Sessions::BaseController
  def show
    token = PasswordResetToken.find_by_token params[:reset_password_id]

    if token.nil? || !token.active?
      redirect_to sessions_reset_token_path, alert: "Cannot reset a password using this link. Please request a new link."
    end
  end
end
