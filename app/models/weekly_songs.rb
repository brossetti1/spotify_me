# == Schema Information
#
# Table name: weekly_songs
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song_id    :integer
#  votes      :integer          default("1")
#  playlist   :integer
#

class WeeklySongs < ActiveRecord::Base
  has_many :songs, through: :votes
  has_many :users, through: :votes
  has_many :votes
  has_many :vetoes
end
