class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :investable, polymorphic: true, index: true
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.date :due_date
      t.string :mail_address
      t.string :other
      t.string :remark
      t.string :state
      t.datetime :booking_date

      t.timestamps null: false
    end
  end
end
