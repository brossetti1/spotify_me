class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :song_id, only: [:suggestion]

  def vote
    
  end

  def veto
  end

  def suggestion
    @song = Song.new()
    @song.process_song(song_id)
    if @song.save
      redirect_to root_path, message: :ok
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end



  private

  def set_user
    @user = User.find(params[:id])
  end

  def song_id
    params[:pick]
  end

end
