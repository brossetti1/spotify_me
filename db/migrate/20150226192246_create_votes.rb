class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.integer :user_id
      t.integer :playlist_id
      t.integer :song_id
      t.string :vote_type

      t.timestamps null: false
    end
  end
end
