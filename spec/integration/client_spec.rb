require 'swagger_helper'

describe 'Clients endpoints' do

  path 'api/v1/client' do

    post 'Create client' do
      tags 'Client'
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
          type: :object,
          properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              goverment_id: { type: :string },
              phone: { type: :string },
              birthdate: { type: :datetime }
          },
          required: [ 'goverment_id', 'first_name', 'last_name' ]
      }

      response '201', 'client created' do
        let(:client) { { first_name: 'Jhon', last_name: 'Doe', birthdate: Time.now, goverment_id: '40256748976', phone: '(809) 988 8888' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:client) { {  } }
        run_test!
      end

    end

  end

end