class AddMoreFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :title4, :string
    add_column :products, :content4, :string
    add_column :products, :title5, :string
    add_column :products, :content5, :string
    add_column :products, :title6, :string
    add_column :products, :content6, :string
    add_column :products, :title7, :string
    add_column :products, :content7, :string
  end
end
