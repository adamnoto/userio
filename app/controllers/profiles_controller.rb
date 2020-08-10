class ProfilesController < ApplicationController
  # normally it might use different layout, but since it's a simple
  # app, let's reuse the session layout.
  layout "session"

  before_action :must_signed_in!

  def show
    @resource = current_user
  end
end
