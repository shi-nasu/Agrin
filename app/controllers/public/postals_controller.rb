class Public::PostalsController < ApplicationController
  def index
    @postals = Postal.all
    @postal = Postal.new
  end

  def edit
    @postal = Postal.find(params[:id])
  end

  def update
    @postal = Postal.find(params[:id])
    if @postal.update(postal_params)
      flash[:notice] = 'successfully'
      redirect_to postals_path
  #失敗した時
    else
      render :edit
    end
  end

  def create
    @postal = Postal.new(postal_params)
    @postal.customer_id = current_customer.id
    @postal.save
    #createが成功した時
    if @postal.update(postal_params)
      flash[:notice] = 'successfully'
      redirect_to postals_path
    end
  end

  def destroy
    postal = Postal.find(params[:id])  # データ（レコード）を1件取得
    postal.destroy  # データ（レコード）を削除
    redirect_to '/postals'  # 投稿一覧画面へリダイレクト
  end

  private

  def postal_params
    params.require(:postal).permit(:postal_code, :address, :name)
  end
end
