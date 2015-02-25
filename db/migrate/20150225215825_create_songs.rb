class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :artist
      t.string :title
      t.string :spotify_id
      t.timestamps null: false
    end
  end
end
