# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  playlist_id :integer
#  song_id     :integer
#  vote_type   :string           default("vote")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#vote_type = 1 => vote 
#vote_type = 2 => veto

class Vote < ActiveRecord::Base
  has_many :user
  has_many :song



  def self.vote(song, user)
    vote = Vote.new()
    vote.user_id = user.id
    vote.song_id = song.id
    user.process_vote
    vote.save
  end
  
  def self.veto(song, user)
    veto = Vote.new()
    veto.user_id = user.id
    veto.song_id = song.id
    veto.vote_type = 'veto'
    user.process_vote
    veto.save
  end


end
