# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

from_date = DateTime.new(2015, 1, 1)
to_date   = DateTime.new(2015, 2, 28)
TRACKS = RSpotify::Track.search('billy', limit: 40)



20.times do 
  User.create(email: Faker::Internet.free_email, 
           password: 'password')
end

def random_user
  user = User.all.sample
  until user.vote_count > 0
    user = User.all.sample
  end
  user
end

def random_track
  TRACKS.sample
end

#stubbing process Song method from Song model to prevent multiple calls to Spotify

def process_song(track, user)
  new_song = Song.new
  new_song.artist = track.artists.first.name
  new_song.title = track.name
  new_song.spotify_id = track.id
  new_song.album = track.album.name
  new_song.user_id = user.id
  new_song.save
  new_song
end

(from_date..to_date).each do |d|
  song = random_track
  user = random_user
  song_found = Song.find_by_spotify_id(song.id)
  if song_found == nil
    new_song = process_song(song, user)
    Vote.vote(new_song, user)
  elsif song_found
    Vote.vote(song_found, user)
  end
  User.all.map do |user| 
    user.vote_count = 5
    user.save
  end
end