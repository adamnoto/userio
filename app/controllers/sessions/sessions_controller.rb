class Sessions::SessionsController < Sessions::BaseController
  def destroy
    sign_out!
    redirect_to sessions_sign_in_path
  end
end
