class ChangeVoteTable < ActiveRecord::Migration
  def change
    rename_column :votes, :weekly_songs_id, :weekly_song_id
    change_column :votes, :vote_type, :string, default: 'vote'
  end

end
