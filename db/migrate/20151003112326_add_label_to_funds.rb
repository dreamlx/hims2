class AddLabelToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :label, :string
  end
end
