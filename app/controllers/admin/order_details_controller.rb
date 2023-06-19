class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
