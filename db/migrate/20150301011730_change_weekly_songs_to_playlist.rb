class ChangeWeeklySongsToPlaylist < ActiveRecord::Migration
  def change
    rename_table :weekly_songs, :playlists
  end
end
