class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = ::User.new(sign_up_params)

    user.save
    render_resource(user)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end