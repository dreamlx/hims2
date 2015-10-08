class AddCurrencyToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :currency, :string
  end
end
