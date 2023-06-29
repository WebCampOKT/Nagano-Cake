class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @items = Item.looks(params[:search], params[:word])
  end
end
