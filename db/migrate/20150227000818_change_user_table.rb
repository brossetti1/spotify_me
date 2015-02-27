class ChangeUserTable < ActiveRecord::Migration
  def change
    add_column :users, :vote, :integer, default: 5
    add_column :users, :veto, :integer, default: 1
  end

end
