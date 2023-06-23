class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @model = params[:model]

    @customers = Customer.looks(params[:search], params[:word])
    @items = Item.looks(params[:search], params[:word])
  end
end
