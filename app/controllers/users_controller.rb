class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_song, only: [:vote, :veto]
  before_action :song_id, only: [:suggestion]

  def vote
    binding.pry
    if current_user.can_vote?
      Vote.vote(@song, current_user)
      flash[:notice] = "your vote has been added to #{@song.title}."
      redirect_to root_path, message: :ok 
    else
      flash[:alert] = "you have no more votes remaining"
      redirect_to root_path, status: unprocessable_entity
    end
  end

  def veto
    if current_user.can_veto?
      Vote.veto(@song, current_user)
      flash[:notice] = "your vote has been added to #{@song.title}."
      redirect_to root_path, message: :ok
    else
      flash[:alert] = "you have no more vetos remaining"
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def suggestion
    binding.pry
    song_found = Song.find_by_spotify_id(song_id)
    if current_user.can_vote?
      if song_found == nil
        song = Song.new
        song.process_song(song_id, current_user); song.save
        Vote.vote(song, current_user)
        flash[:notice] = "your song has been suggested for this weeks playlist."
        redirect_to root_path, message: :ok
      elsif song_found
        Vote.vote(song_found, current_user)
        flash[:notice] = "the song you selected was already suggested, so we added a vote."
        redirect_to root_path, message: :ok
      end
    else
      flash[:alert] = "you have no more votes remaining"
      redirect_to root_path status: :unprocessable_entity 
    end
  end



  private

  def song_id
    params[:pick]
  end

  def set_song
    @song = Song.find(params[:song_id])
  end

end
