module UserClientService
  class << self
    def create_new_safe(user_client)
      existing_user = ::UserClient.find_by(email: user_client[:email])

      if !existing_user.present?
        user_client = ::UserClient.new(:email => user_client[:email], :password => user_client[:password], :password_confirmation => user_client[:password], :full_name => user_client[:full_name], :goverment_id => user_client[:goverment_id])
        user_client.save!
        return user_client
      end

      existing_user
    end
  end
end