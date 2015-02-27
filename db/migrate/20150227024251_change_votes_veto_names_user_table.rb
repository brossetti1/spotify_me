class ChangeVotesVetoNamesUserTable < ActiveRecord::Migration
  def change
    rename_column :users, :votes, :vote_count
    rename_column :users, :veto, :veto_count
  end
end
