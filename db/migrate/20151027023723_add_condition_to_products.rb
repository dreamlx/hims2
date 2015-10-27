class AddConditionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :condition, :text
  end
end
