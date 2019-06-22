class Api::V1::Loan::LoansController < ApplicationController

  def create

    client = ::Client.find(create_loan_params[:client_id])
    if client.present?
      loan = ::LoansService.create(create_loan_params, client, @user)
      articles = ArticlesService.create_many(create_articles_params, loan)
      quotes = ::LoansService.calculate_quotes(loan)

      user_client = ::UserClientService.create_new_safe({email: client[:email], password: client[:goverment_id], goverment_id: client[:goverment_id], full_name: "#{client[:first_name]} #{client[:last_name]}"})

      if !articles.empty?
        render json: {
            loan: ::Loan.find(loan[:id]).sanitazed_info,
            quotes: quotes,
            user_client: user_client
        }
      else
        render json: {
            message: "Couldn't create associated articles to this loan, try again"
        }, :status => :not_found
      end
    else
      render json: nil, :status => :bad_request
    end

  rescue ActiveRecord::RecordInvalid => e
    if quotes.present?
      quotes.destroy!
    end
    if articles.present?
      articles.destroy!
    end
    if loan.present?
      loan.destroy!
    end
    render json: {
        error: e
    }, :status => :unprocessable_entity

  end

  def show
    render json: {
        loans: ::Loan.all.map(&:sanitazed_info)
    }, :status => :ok
  end

  def options
    render json: {
        categories: LoanCategory.all
    }
  end


  private

    def create_loan_params
      params.require(:loan).permit(:amount_to_pay, :category_id, :client_id, :appraise, :observations, :loan_payment_frecuency_id, :loan_duration)
    end

    def create_articles_params
      params.require(:articles)
    end

end
