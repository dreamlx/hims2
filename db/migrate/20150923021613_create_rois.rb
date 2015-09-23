class CreateRois < ActiveRecord::Migration
  def change
    create_table :rois do |t|
      t.references :product, index: true, foreign_key: true
      t.string :range
      t.string :profit

      t.timestamps null: false
    end
  end
end
