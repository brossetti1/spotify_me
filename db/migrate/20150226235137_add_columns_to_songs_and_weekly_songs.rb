class AddColumnsToSongsAndWeeklySongs < ActiveRecord::Migration
  
  def change
    add_column :weekly_songs, :playlist, :integer
    remove_column :weekly_songs, :veto
  end

end


  