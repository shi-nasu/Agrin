class Public::CustomersController < ApplicationController
  
def status
  end
  
  def new
    @customers = Cust.new
  end
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end

  def unsubscribe
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params) #34行目から情報を取ってきている
      flash[:notice] = 'successfully'
      redirect_to customers_my_page_path
  #失敗した時
    else
      render :edit
    end
  end

  def withdraw
    @customer = current_customer #定義
    @customer.update(is_deleted: true) #退会ステータスをtrue
    reset_session #ログアウトの処理
    redirect_to root_path #topページに飛ぶ
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end
  
end
