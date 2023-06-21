class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def status_update
    @order = Order.find(params[:order][:id])
    if @order.update(params_int(order_params))
      order_status_confermation?(@order)
      redirect_back(fallback_location: )
    end
  end

  def product_status_update
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:product_status, :id)
  end

  def integer_string?(str)
    Integer(str)
  end

  def params_int(order_params)
    order_params.each do |key, value|
      if integer_string?(value)
        order_params[key] = value.to_i
      end
    end
  end

  def order_status_confermation?(order)
    if order.status == 1
      order.product_orders.each do |product_order|
        product_order.update(product_status: 1)
      end
    end
  end

  def product_status_product_waiting?(order_detail)
    if order_detail.product_status == 2
      order_detail.order.update(status: 2)
    end
  end

  def product_status_compelition?(order)
    if order.order_detalis.all? do |order_detail|
      order_detail.product_status == 3
    end
      order.update(status: 3)
    end
  end

end
