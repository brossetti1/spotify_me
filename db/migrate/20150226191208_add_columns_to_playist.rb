class AddColumnsToPlayist < ActiveRecord::Migration
  def change
    add_column :playlists, :song_id, :integer, unique: true
    add_column :playlists, :veto, :boolean, default: false
    add_column :playlists, :votes, :integer, default: 1
  end
end
