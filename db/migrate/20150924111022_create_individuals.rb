class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :cell
      t.string :remark_name
      t.string :id_type
      t.string :id_no
      t.string :id_front
      t.string :id_back
      t.string :remark

      t.timestamps null: false
    end
  end
end
