class Api::V1::Quote::QuotesController < ApplicationController

  def show
    if params[:loan_id].present?
      loan = ::Loan.find(params[:loan_id])
      if loan.present?
        quotes = ::LoanQuote.where(loan_id: params[:loan_id]).map(&:sanitazed_info)
        render json: {
            quotes: quotes
        }, :status => :ok
      else
        render json: {
            message: 'not found'
        }, status: :not_found
      end
    else
      render json: {
          message: "provide loan id"
      }, :status => :bad_request
    end
  end
end
