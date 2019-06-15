class Business < ApplicationRecord
  belongs_to :user

  def create_new(params, user)
    ::Business.new(name: params[:name], addres: params[:address], latitude: params[:latitude], longitude: params[:longitude], phone: params[:phone], user: user)
  end

  def sanitazed_info
    {
        id: id,
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        phone: phone,
        user: ::User.find(user_id).sanitized_info
    }
  end

end
