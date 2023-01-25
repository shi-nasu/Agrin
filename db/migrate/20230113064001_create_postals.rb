class CreatePostals < ActiveRecord::Migration[6.1]
  def change
    create_table :postals do |t|

      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :customer_id

      t.timestamps
    end
  end
end
