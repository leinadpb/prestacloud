module BusinessService
  class << self
    def create(params, user)
      Business.create(
          name: params[:name],
          address: params[:address],
          latitude: params[:latitude],
          longitude: params[:longitude],
          phone: params[:phone],
          user_id: user[:id])
    end
  end
end