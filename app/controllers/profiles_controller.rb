class ProfilesController < ApplicationController
  # normally it might use different layout, but since it's a simple
  # app, let's reuse the session layout.
  layout "session"

  before_action :must_signed_in!

  def show
    @resource = current_user
  end

  def update
    change_requests = permitted_params.to_h
    change_requests.delete :password if change_requests[:password].blank?

    if current_user.update change_requests
      flash[:notice] = "Profile updated successfully"
    else
      flash[:alert] = current_user.errors.full_messages.join(". ")
    end
    redirect_to profile_path
  end

  private

    def permitted_params
      params.require(:user).permit(:username, :password)
    end

end
