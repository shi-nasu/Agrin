class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount])
    redirect_to '/cart_items'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])  # データ（レコード）を1件取得
    @cart_item.destroy  # データ（レコード）を削除
    redirect_to '/cart_items'  # 投稿一覧画面へリダイレクト
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all #　全て削除する
    redirect_to '/cart_items'
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #↓再度同じ商品の数量を増やす記述↓
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update(amount: new_amount)
        return redirect_to cart_items_path
      end
    end
    @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
