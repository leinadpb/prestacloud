class Api::V1::User::UsersController < ApplicationController

  def show
    render json: {
        user: current_user
    }, :status => :ok
  end

end
