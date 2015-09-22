class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :fund, index: true, foreign_key: true
      t.string :name
      t.string :desc
      t.string :title1
      t.string :content1
      t.string :title2
      t.string :content2
      t.string :title3
      t.string :content3
      t.integer :progress_bar, default: 0
      t.string :abbr
      t.string :currency
      t.string :amount
      t.string :period
      t.string :paid
      t.string :sales_period
      t.string :block_period
      t.string :redeem
      t.string :entity
      t.string :adviser
      t.string :trustee
      t.string :reg_organ
      t.string :website
      t.string :agency
      t.string :regulatory_filing
      t.string :legal_consultant
      t.string :audit
      t.string :starting_point
      t.string :account
      t.string :progress
      t.string :direction
      t.string :risk_control
      t.string :instruction
      t.string :agreement

      t.timestamps null: false
    end
  end
end
