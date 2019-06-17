# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  include Accessible

  skip_before_action :check_user, only: :destroy

  private

  def respond_with(resource, _opts = {})
    puts resource.inspect
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
