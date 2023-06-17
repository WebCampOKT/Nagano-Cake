class Public::ItemsController < ApplicationController
  # before_action :authenticate_customer!
  
  def index
    @items = Item.all
  end

  def show
    tax = 1.1
    @item = Item.find(params[:id])
    @in_tax = (@item.price * tax).to_i
  end
end
