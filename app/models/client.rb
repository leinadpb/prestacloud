class Client < ApplicationRecord

  has_many :loans


  def sanitazed_info
    {
        id: id,
        first_name: first_name,
        last_name: last_name,
        goverment_id: goverment_id,
        phone: phone,
        email: email,
        loans: Loan.where(client_id: id).map(&:sanitazed_info_without_client),
        stripe_id: ::UserClient.find_by(goverment_id: goverment_id).get_stripe_id
    }
  end
end
