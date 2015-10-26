class AddStates < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
    add_column :individuals, :state, :string
    add_column :institutions, :state, :string

    User.update_all(state: "提交")
    Individual.update_all(state: "提交")
    Institution.update_all(state: "提交")
  end
end
