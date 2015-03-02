# == Schema Information
#
# Table name: playlists
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#


class Playlist < ActiveRecord::Base
  has_many :songs

  def start_time
    self.created_at - 1.week
  end

  def end_time
    self.created_at
  end

  def self.create_playlist
    playlist = Playlist.create()
    songs = Song.where(created_at: playlist.start_time..playlist.end_time)
    songs.each {|song| song.update_attributes(playlist_id: playlist.id)}
  end

  def get_playlist(week)
    
  end
end 