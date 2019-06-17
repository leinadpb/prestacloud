# frozen_string_literal: true

class UserClients::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy

  include ActionController::Cookies
  respond_to :json


  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
