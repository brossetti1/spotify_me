# == Schema Information
#
# Table name: vetos
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  weekly_songs_id :integer
#  song_id         :integer
#  veto_type       :string           default("veto")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

#  create_table "vetos", force: :cascade do |t|
#    t.integer  "user_id"
#    t.integer  "weekly_songs_id"
#    t.integer  "song_id"
#    t.string   "veto_type",       default: "veto"
#    t.datetime "created_at",                       null: false
#    t.datetime "updated_at",                       null: false

class Veto < ActiveRecord::Base
  belongs_to :weekly_songs
  belongs_to :user
  belongs_to :song

  def self.veto(song, user)
    veto = Veto.new
    veto.user_id = user.id
    veto.song_id = song.id
    veto.save
  end
end
