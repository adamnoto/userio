class Sessions::ResetTokenController < Sessions::BaseController
  def new
  end

  def create
    email = params[:user][:email]
    user = User.find_by_email email

    if user
      token = user.password_reset_tokens.create!
      # normally, we should use deliver_later and use a background
      # job to send the email.
      UserMailer.reset_password_email(token).deliver_now
    end

    redirect_to sessions_sign_in_path,
      notice: "If you have an account with us, we will send you an email with a guide on how to reset your password"
  end
end
