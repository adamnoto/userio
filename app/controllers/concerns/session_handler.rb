module SessionHandler
  extend ActiveSupport::Concern

  # normally, we should store this in Rails credentials. but, to make it easy
  # to setup and run this app, let's make it static for now. this is definitely
  # not a secure thing to do in a real production application.
  SESSION_KEY_BASE = "SESSION_KEY_BASE_THAT_SHOULD_BE_SECRET".freeze

  SESSION_COOKIE_NAME = "userio_session".freeze

  def session_verifier
    @session_verifier ||= ActiveSupport::MessageVerifier.new(SESSION_KEY_BASE)
  end

  def setup_cookies_for_user user
    signed_user_id = session_verifier.generate user.id

    cookies.permanent[SESSION_COOKIE_NAME] = {
      value: signed_user_id,
      domain: :all,
      http_only: true,
    }
  end

  def must_signed_in!
    return if current_user

    redirect_to sessions_sign_in_path
  end

  def current_user
    @current_user ||= begin
      user_id = cookies.permanent[SESSION_COOKIE_NAME]
      user_id = session_verifier.verify user_id
      User.find user_id
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def redirect_if_signed_in!
    return unless current_user

    redirect_to profile_path
  end

  def sign_out!
    cookies.delete SESSION_COOKIE_NAME
  end
end
