class Api::V1::ClientUsers::Card::CardsController < ApplicationController
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

  def add_customer
    client = ::UserClient.find_by(goverment_id: params[:goverment_id])
    if params[:card_token].present?
      if client.present?
        customer = Stripe::Customer.create({ description: client[:email], source: params[:card_token] })
        client[:stripe_id] = customer[:id]
        client.save!

        if params[:card].present?
          create_card(params[:card])
        end

        render json: {
            client: client
        }, :status => :ok
      else
        render json: {
            message: "Client user not found. User logged in: #{params[:goverment_id]}"
        }, :status => :bad_request
      end
    else
      render json: {
          message: "Please, provide a card token"
      }, :status => :ok
    end
  end

  def get_cards
    client = ::UserClient.find_by(goverment_id: params[:goverment_id])
    customer = Stripe::Customer.retrieve(client[:stripe_id])
    render json: {
        cards: customer[:sources][:data]
    }, :status => :ok
  end

  def create_card(card)
    puts create_card_params.inspect
    card = Stripe::Token.create({ card: {
        number: create_card_params[:number],
        exp_month: create_card_params[:exp_month],
        exp_year: create_card_params[:exp_year],
        cvc: create_card_params[:cvc],
        currency: create_card_params[:currency],
        name: create_card_params[:name]
    } })
    if card.present?
      render json: {
          card: card
      }, :status => :ok
    else
      render json: {
          message: "card could be created by stripe."
      }, :status => :bad_request
    end
  end

  def create_card_params
    params.require(:card).permit(:number, :exp_month, :exp_year, :cvc, :currency, :name)
  end
end
