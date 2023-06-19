# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state,only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  protected
  # 退会しているかの確認
  def customer_state
    # 入力されたメールアドレスからアカウントを取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、メソッドを終了
    return if !@customer
    # 取得できた場合、パスワードを照合し退会済みであれば新規登録画面へ遷移
    if @customer.valid_password?(:params[:customer][:password]) && (@customer.is_active == true)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_customer_registration_path
     
    elsif @customer.valid_password?(:params[:customer][:password]) && (@customer.is_active == false)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_customer_registration_path
    end
  end
end
