class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :subtotal
      t.decimal :tax_total
      t.decimal :grand_total

      t.timestamps
    end
  end
end
