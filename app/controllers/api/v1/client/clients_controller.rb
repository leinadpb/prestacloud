class Api::V1::Client::ClientsController < ApplicationController

  def create
    client = ::ClientsService.create(create_client_params)
    render json: {
        client: client
    }, :status => :ok
  end


  private

  def create_client_params
    params.require(:client).permit(:first_name, :last_name, :birthdate, :goverment_id, :phone)
  end

end
