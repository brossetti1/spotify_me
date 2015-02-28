# == Schema Information
#
# Table name: votes
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  weekly_songs_id :integer
#  song_id         :integer
#  vote_type       :integer          default("1")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


#vote_type = 1 => vote 
#vote_type = 2 => veto

class Vote < ActiveRecord::Base
  belongs_to :weekly_songs
  belongs_to :user
  belongs_to :song



  def self.vote(song, user)
    vote = Vote.new()
    vote.user_id = user.id
    vote.song_id = song.id
    vote.save
  end
  
  def self.veto(song, user)
    veto = Vote.new
    veto.user_id = user.id
    veto.song_id = song.id
    veto.vote_type = 'veto'
    veto.save
  end


end
