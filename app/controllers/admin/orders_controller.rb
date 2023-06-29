class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_params)
      if @order.status  == "payment_confirmation"
        @order_details.update_all(product_status: 1)
      end
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
