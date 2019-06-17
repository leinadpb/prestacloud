# frozen_string_literal: true

class UserClients::SessionsController < Devise::SessionsController
  respond_to :json
  include Accessible

  skip_before_action :check_user, only: :destroy

  def create
    puts auth_options.inspect
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
