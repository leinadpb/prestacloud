class Api::V1::User::UsersController < ApplicationController

  def show
    render json: {
        user: @user
    }, :status => :ok
  end

end
