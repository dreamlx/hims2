class AddDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :id_type, :string
    add_column :users, :nickname, :string
    add_column :users, :gender, :string
    add_column :users, :address, :string
    add_column :users, :card_type, :string
    add_column :users, :card_no, :string
    add_column :users, :card_front, :string
    add_column :users, :card_back, :string
    add_column :users, :remark, :string
  end
end
