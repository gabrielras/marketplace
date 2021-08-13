 class Client::ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:edit, :update]

  def new
    @review = Review.find_by(client_id: current_client.id, product_id: @order_product.product_id)
    if @review.present?
      return redirect_to edit_client_order_product_review_path(@order_product, @review)
    end
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to edit_client_order_product_review_path(@order_product, @review), notice: 'A avaliação foi criada com sucesso.'
    else
      redirect_to new_client_order_product_review_path(@order_product), notice: 'Houve um problema para salvar a avaliação.'
    end
  end

  def update
    @review.update(review_params)
    if @review.save
      redirect_to edit_client_order_product_review_path(@order_product, @review), notice: 'A avaliação foi salva com sucesso.'
    else
      redirect_to edit_client_order_product_review_path(@order_product, @review), notice: 'Houve um problema para salvar a avaliação.'
    end
  end
  
  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_product
    @order_product = OrderProduct.find(params[:order_product_id])
  end

  def review_params
    params.require(:review).permit(:text, :value).merge(product_id: @order_product.product_id , client_id: current_client.id)
  end
end
