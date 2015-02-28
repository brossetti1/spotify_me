module HomeHelper
  
  def song_list
    Song.all.order([:votes].count)
  end

end
