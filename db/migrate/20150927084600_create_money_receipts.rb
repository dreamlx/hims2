class CreateMoneyReceipts < ActiveRecord::Migration
  def change
    create_table :money_receipts do |t|
      t.references :order, index: true, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.decimal :bank_charge, precision: 12, scale: 2, default: 0
      t.date :date
      t.string :attach
      t.string :state

      t.timestamps null: false
    end
  end
end
