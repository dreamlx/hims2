class AddRateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rate, :text
  end
end
