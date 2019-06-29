class Api::V1::Client::ClientsController < ApplicationController

  def create
    client = ::ClientsService.create(create_client_params)
    render json: {
        client: client
    }, :status => :created
  end

  def show
    clients = ::Client.all
    render json: {
        clients: clients.map(&:sanitazed_info)
    }, :status => :ok
  end

  def search_by
    if params[:goverment_id].present?
      client = ::Client.find_by(:goverment_id => params[:goverment_id])
      render json: {
          client: client
      }, :status => :ok
    else
      render json: {
          message: "Provide the goverment_id attribute"
      }, :status => :bad_request
    end
  end

  def show_loans
    client = ::Client.find_by(:goverment_id => params[:goverment_id])
    render json: {
      client: client.sanitazed_info
    }
  end


  private

  def create_client_params
    params.require(:client).permit(:first_name, :last_name, :birthdate, :goverment_id, :phone, :email)
  end

end
