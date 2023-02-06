class OrderDetail < ApplicationRecord
  
  enum making_status: { cannot_manufactured: 0, waiting_production: 1, production: 2, completion_production: 3}

  belongs_to :item
  belongs_to :order
  def subtotal
    price * amount
  end
end
