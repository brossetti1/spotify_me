class ChangeWeeklySongsInVote < ActiveRecord::Migration
  def change
    rename_column :votes, :weekly_song_id, :weekly_songs_id
  end
end
