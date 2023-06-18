class Public::ShippingAddressesController < ApplicationController
  #before_action :authenticate_customer!
  before_action :find_shipping_address, only: [:edit, :update, :destroy]
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.all
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      @shipping_address = ShippingAddress.new
      @shipping_addresses = ShippingAddress.all
      render :index
    end
  end

  def edit
  end

  def update
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end

  def destroy
    if @shipping_address.destroy
      redirect_to shipping_addresses_path
    end
  end

  private

  def find_shipping_address
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end
end
