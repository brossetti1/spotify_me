class HomeController < ApplicationController

  def index

  end

  def spotify_search
    @search_results = []
    if search_params
      tracks = RSpotify::Track.search(search_params, limit: 10)
      # artists = RSpotify::Artist.search('Arctic Monkeys')
      # playlists = RSpotify::Playlist.search('Indie')
      # albums = RSpotify::Album.search('The Wall')
      @query = search_params
      @count = tracks.total
      @search_results = tracks
    end

    render :show
  end

  def show

  end


  private

  def search_params
    params[:search_query]
  end

end
