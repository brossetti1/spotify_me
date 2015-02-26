class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_song, only: [:vote, :veto]
  before_action :song_id, only: [:suggestion]

  def vote
    
  end

  def veto
  end

  def suggestion
    @song = Song.new()
    @song.process_song(song_id, current_user)
    if @song.save
      redirect_to root_path, message: :ok
    else
      redirect_to root_path, status: :unprocessable_entity
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
