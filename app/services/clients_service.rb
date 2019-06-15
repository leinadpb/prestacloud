module ClientsService
  class << self
    def create(client)
      ::Client.create!(
          goverment_id: client[:goverment_id],
          phone: client[:phone],
          first_name: client[:first_name],
          last_name: client[:last_name],
          birthdate: client[:birthdate])
    end

    def get_all_by_user(user)
      clients = ::Client.where(id: user[:id]).map(&:sanitazed_info)
      clients
    end
  end
end