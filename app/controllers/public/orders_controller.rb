class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  #before_action :full_addresses
  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses.all
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
        @order_detail = OrderDetail.new #初期化宣言
        @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
        @order_detail.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
        @order_detail.subtotal = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
        @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
        @order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render 'new'
    end
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      ship = ShippingAddress.find(params[:order][:customer_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name
    elsif params[:order][:address_option] = "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end

  end

  def complete
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  #def full_addresses
    #current_customer.shipping_addresses.postal_code + current_customer.shipping_addresses.address + current_customer.shipping_addresses.name
  #end

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :status, :total_price, :customer_id, :shipping_cost)
  end
end
