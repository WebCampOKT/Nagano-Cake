class Admin::CustomersController < ApplicationController
  
  
  # 会員一覧
  def index
    @customers = Customer.all
  end
  
  # 会員詳細画面
  def show
    @customer = Customer.find(params[:id])
  end

  # 会員編集画面
  def edit
    @customer = Customer.find(params[:id])
  end

  # 会員情報更新
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path,notice: "You have updated customer successfully."
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number)
    end
end
