class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.references :order, index: true, foreign_key: true
      t.string :category
      t.string :field_name
      t.string :field_type
      t.string :string
      t.text :text
      t.string :photo
      t.string :state

      t.timestamps null: false
    end
  end
end
