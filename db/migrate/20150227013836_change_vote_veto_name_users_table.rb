class ChangeVoteVetoNameUsersTable < ActiveRecord::Migration
  def change
    rename_column :users, :vote, :votes
  end
end
