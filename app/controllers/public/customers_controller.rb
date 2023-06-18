class Public::CustomersController < ApplicationController

    # 顧客のマイページ
    def show
        @customer = current_customer
    end

    # 顧客の登録情報編集画面
    def edit
        @customer = current_customer
    end

    # 顧客の登録情報更新
    def update
        @customer = current_customer
        @customer.update(customer_params)
        redirect_to customers_my_page_path
    end

    # 顧客の退会確認画面
    def unsubscribe
    end

    # 顧客の退会処理（ステータスの更新）
    def withdrawal
    end

    private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number)
    end

end
