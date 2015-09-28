class CreateInfoFields < ActiveRecord::Migration
  def change
    create_table :info_fields do |t|
      t.references :product, index: true, foreign_key: true
      t.string :category
      t.string :field_name
      t.string :field_type

      t.timestamps null: false
    end
  end
end
