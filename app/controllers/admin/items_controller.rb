class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_select_genres

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品情報を登録しました。"
    else
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品情報を変更しました。"
    else
      render 'new'
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :caption, :price, :is_sales, :image)
  end

  def set_select_genres
    @genres = Genre.all.map {|genre| [genre.name, genre.id] }.unshift(["--選択してください--", nil])
  end
end