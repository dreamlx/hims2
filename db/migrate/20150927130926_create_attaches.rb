class CreateAttaches < ActiveRecord::Migration
  def change
    create_table :attaches do |t|
      t.string :title
      t.string :attach
      t.references :attachable, polymorphic: true, index: true
      t.string :category

      t.timestamps null: false
    end
  end
end
