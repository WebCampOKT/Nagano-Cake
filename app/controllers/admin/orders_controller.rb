class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def status_update
    @order = Order.find(params[:order][:id])
    @order.update(order_params)
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

  def order_status_payment_waiting?(order)
    if order.order_status_before_type_cast == 1
      order.product_orders.each do |p|
        p.update(product_order_status: 1)
      end
      flash[:info] = "製作ステータスが「製作待ち」に更新されました"
    end
  end

  def order_status_confermation?(order)
  end

  def product_status_product_waiting?(order_detail)
  end

  def product_status_compelition?(order_detail)
  end

end
