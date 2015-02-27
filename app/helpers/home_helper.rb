module HomeHelper



  def first_song 
    Song.first
  end

  def song_list
    Song.all.map do |x|
      x.title
    end
  end

  def artist_list
    Song.all.map do |x|
      x.artist
    end
  end

end
