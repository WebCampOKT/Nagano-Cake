class Public::OrdersController < ApplicationController
  #before_action :authenticate_customer!
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
    @order = Order.new(order_params)
    #[:address_option]=="0"のデータ(customerの住所)を呼び出す
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
　　　　#orderのmember_id(=カラム)でアドレス(帳)を選び、そのデータ送る
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
  end

  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :status, :total_price)
  end
end
