# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  artist      :string
#  title       :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album       :string
#  user_id     :integer
#  playlist_id :integer
#

class Song < ActiveRecord::Base
  belongs_to :users
  has_many :votes
  has_many :users, through: :votes
  belongs_to :playlist


  def process_song(spotify_id, user)
    track = Song.find_track(spotify_id)
    self.artist = track.artists.first.name
    self.title = track.name
    self.spotify_id = spotify_id
    self.album = track.album.name
    self.user_id = user.id
    self.save
  end

  def self.find_track(id)
    RSpotify::Track.find(id)
  end

  def self.votes_count
    Song.all.to_a.sort_by {|song| song.votes.count}
  end

  def veto_count
    self.votes.where(vote_type: "veto").count
  end

end
