class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :cell
      t.string :remark_name
      t.string :organ_reg
      t.string :business_licenses
      t.string :remark

      t.timestamps null: false
    end
  end
end
