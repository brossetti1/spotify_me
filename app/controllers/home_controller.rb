class HomeController < ApplicationController

  def index

  end

  def spotify_search
    binding.pry
    @search_results = []
    if search_params
      # artists = RSpotify::Artist.search('Arctic Monkeys')
      # playlists = RSpotify::Playlist.search('Indie')
      # albums = RSpotify::Album.search('The Wall')
      @count = tracks.total
      @search_results = RSpotify::Track.search(search_params, limit: 10)
    end
    redirect_to :show
  end

  def show
    
  end


  private

  def search_params
    params[:search_query]
  end

end
