class ChangeWeeklySongsIDtoPlaylistsId < ActiveRecord::Migration
  def change
    rename_column :votes, :weekly_songs_id, :playlist_id
  end
end
