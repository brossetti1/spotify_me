module HomeHelper
  
  def song_list
    Song.all.sample(10)
  end

end
