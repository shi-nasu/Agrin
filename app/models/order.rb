class Order < ApplicationRecord

  enum status: { waiting_payment: 0, payment_confirmation: 1, production: 2, preparation: 3, shipped: 4}
  enum payment_method: { credit_card: 0, transfer: 1}

  has_many :order_details
  belongs_to :customer

end
