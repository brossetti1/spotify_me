# == Schema Information
#
# Table name: playlists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Playlist < ActiveRecord::Base
  has_many :songs
end
