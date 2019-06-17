class Api::V1::ClientUsers::LoanUser::LoanUsersController < ApplicationController

  # before_action :authenticate_user!

  def show
    render json: {
        loans: current_user_client.get_client.loans.map(&:sanitazed_info_without_client)
    }, :status => :ok
  end

end
