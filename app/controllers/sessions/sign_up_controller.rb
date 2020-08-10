class Sessions::SignUpController < Sessions::BaseController
  def new
    @resource = User.new
  end

  def create
    raise NotImplementedError
  end
end
