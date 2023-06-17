class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer_id
    if @order.save
      redirect_to order_confirm_path(@order)
    else
      render 'new'
    end
  end

  def confirm
  end

  def complete
  end

  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name)
  end
end
