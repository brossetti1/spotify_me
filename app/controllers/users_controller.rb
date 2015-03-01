class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_song, only: [:vote, :veto]
  before_action :song_id, only: [:suggestion]

  def vote
    if current_user.can_vote?
      @vote = Vote.vote(@song, current_user)
      respond_to do |format|
        flash[:notice] = "your vote has been added to #{@song.title}."
        format.html {render :index, message: :ok }
        format.json {render json: "json/song_vote.json.jbuilder", status: :ok}
        format.js
      end
    else
      respond_to do |format|
        flash[:alert] = "you have no more votes remaining"
        format.html {render :index, status: :unprocessable_entity}
        format.json {render json: flash[:alert], status: :unprocessable_entity}
        format.js
      end
    end
  end

  def veto
    if current_user.can_veto?
      @veto = Vote.veto(@song, current_user)
      respond_to do |format|
        flash[:notice] = "your veto has been added to #{@song.title}."
        format.html {render :index, message: :ok}
        format.json {render "json/song_vote.json.jbuilder", status: :unprocessable_entity}
        format.js
      end
    else
      respond_to do |format|
        flash[:alert] = "you have no more vetos remaining"
        format.html {render :index, status: :unprocessable_entity}
        format.json {render json: flash[:alert], status: :unprocessable_entity}
        format.js
      end
    end
  end

  def suggestion
    song_found = Song.find_by_spotify_id(song_id)
    if current_user.can_vote?
      if song_found == nil
        @song = Song.new
        @song.process_song(song_id, current_user)
        @vote = Vote.vote(@song, current_user)
        respond_to do |format|
          binding.pry
          flash[:notice] = "your song has been suggested for this weeks playlist."
          format.html {render :template => 'home/index', message: :ok}
          format.json {render json: "json/song_vote.json.jbuilder", message: :ok}
          format.js
        end
      elsif song_found
        @vote = Vote.vote(song_found, current_user)
        flash[:notice] = "the song you selected was already suggested, so we added a vote."
        respond_to do |format|
          format.html {render :template => 'home/index', message: :ok}
          format.json {render json: "json/song_vote.json.jbuilder", message: :ok}
          format.js
        end
      end
    else
      respond_to do |format|
        flash[:alert] = "you have no more votes remaining"
        format.html { render :template => 'home/index', status: :unprocessable_entity }
        format.json { render json: flash[:alert], status: :unprocessable_entity }
        format.js
      end
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
