class AddDeliverToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :deliver, :string, default: "未快递"
  end
end
