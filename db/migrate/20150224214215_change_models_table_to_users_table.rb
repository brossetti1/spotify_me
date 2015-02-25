class ChangeModelsTableToUsersTable < ActiveRecord::Migration
  def change
    rename_table :models, :users
  end
end
