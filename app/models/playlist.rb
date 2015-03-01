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
end

def cutoff_time
   self.created_at - 1.week..self.created_at
end

def playlist_creation_range
  Song.where(created_at: self.cutoff_time)
end

def get_playlist(week)
  
end