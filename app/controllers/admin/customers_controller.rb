class Admin::CustomersController < ApplicationController
# before_action :autheticate_admin!

  # 会員一覧
  def index
    @customers = Customer.page(params[:page]).per(10)
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
    if @customer.update(customer_params)
      redirect_to admin_customer_path,notice: "会員情報を更新しました。"
    else
      render 'edit'
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number, :is_active)
    end
end
