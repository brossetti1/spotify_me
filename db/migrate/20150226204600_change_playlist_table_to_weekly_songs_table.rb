class ChangePlaylistTableToWeeklySongsTable < ActiveRecord::Migration
  def change
    rename_table :playlists, :weekly_songs
  end
end
