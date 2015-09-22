class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.string :desc
      t.string :title1
      t.string :content1
      t.string :title2
      t.string :content2
      t.string :title3
      t.string :content3
      t.integer :progress, default: 0

      t.timestamps null: false
    end
  end
end
