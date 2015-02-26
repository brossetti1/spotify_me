# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  artist     :string
#  title      :string
#  spotify_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album      :string
#  user_id    :integer
#

class Song < ActiveRecord::Base
  has_and_belongs_to_many :users



  def process_song(spotify_id, user)
    track = Song.find_track(spotify_id)
    self.artist = track.artists.first.name
    self.title = track.name
    self.spotify_id = spotify_id
    self.album = track.album.name
    self.user_id = user.id
  end

  def self.find_track(id)
    RSpotify::Track.find(id)
  end

end
