class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]

  def index
    @items = Item.all
    @genres = Genre.all
    @genre = Genre.joins(:items)
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
