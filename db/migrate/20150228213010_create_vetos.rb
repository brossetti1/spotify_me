class CreateVetos < ActiveRecord::Migration
  def change
    create_table :vetos do |t|
      t.integer  "user_id"
    t.integer  "weekly_songs_id"
    t.integer  "song_id"
    t.string   "veto_type",       default: "veto"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    end
  end
end
