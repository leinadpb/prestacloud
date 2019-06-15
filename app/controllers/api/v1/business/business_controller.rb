
class Api::V1::Business::BusinessController < ApplicationController
  include BusinessService

  def show
    business = ::Business.find_by(user_id: @user[:id])
    if business.present?
      render json: {
          business: business.sanitazed_info
      }, :status => :ok
    else
      render json: {
          business: nil
      }, :status => :not_found
    end
  end

  def create
    business = BusinessService.create(create_params, @user)
    if business.save
      render json: {
          business: business.sanitazed_info
      }, :status => :ok
    else
      render json: {
          business: nil,
          message: "The business couldn't be created, please, verify your request data object."
      }, :status => :not_found
    end
  end


  def create_params
    params.require(:business).permit(:name, :address, :phone, :latitude, :longitude, :phone, :owner)
  end

end
