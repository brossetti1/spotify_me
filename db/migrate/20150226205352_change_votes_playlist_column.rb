class ChangeVotesPlaylistColumn < ActiveRecord::Migration
  def change
    rename_column :votes, :playlist_id, :weekly_songs_id
  end
end
