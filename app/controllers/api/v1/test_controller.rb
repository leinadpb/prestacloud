class Api::V1::TestController < ApplicationController

  skip_before_action :authenticate_user!, only: [:unsecured]

  def secured
    render json: {
        message: 'works!',
        user: current_user
    }, :status => :ok
  end

  def unsecured
    render json: {
        message: 'works!',
        user: nil
    }, :status => :ok
  end

end
