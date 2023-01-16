class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to '/admin/items'
  end

  #updateが成功した時
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'successfully'
      redirect_to admin_item_path(@item.id)
  #失敗した時
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :introduction, :name, :price, :is_active, :image, :is_active)
  end
end
