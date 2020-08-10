class Sessions::SignInController < Sessions::BaseController
  before_action :redirect_if_signed_in!

  def new
    # TODO: redirect if already signed in
  end

  def create
    raise NotImplementedError
  end
end
