class Client < ApplicationRecord

  has_many :loans


  def sanitazed_info
    {
        id: id,
        first_name: first_name,
        last_name: last_name,
        goverment_id: goverment_id,
        phone: phone,
        loans: Loan.where(client_id: id).map(&:sanitazed_info_without_client)
    }
  end
end
