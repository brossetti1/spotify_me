# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

artists = ['jack johnson', 'billy joel', 'ben harper']

20.times do 
  User.create(email: Faker::Internet.free_email, 
           password: 'password')
end

artists.each do |artist|
  from_date = DateTime.new(2015, 1, 1)
  to_date   = DateTime.new(2015, 2, 28)

  def search_tracks
    RSpotify::Track.search(artist, limit: 30)
  end

  def random_user
    user = User.all.sample
    until user.vote_count > 0
      user = User.all.sample
    end
    user
  end

  def random_track(tracks)
    tracks.sample
  end

  #stubbing process Song method from Song model to prevent multiple calls to Spotify

  def process_song(track, user, date)
    new_song = Song.new
    new_song.artist = track.artists.first.name
    new_song.title = track.name
    new_song.spotify_id = track.id
    new_song.album = track.album.name
    new_song.user_id = user.id
    new_song.created_at = date
    new_song.save
    new_song
  end


  class Vote < ActiveRecord::Base
    has_many :users
    has_many :songs

    def self.vote(song, user, date)
      vote = Vote.new()
      vote.user_id = user.id
      vote.song_id = song.id
      vote.created_at = date
      user.process_vote
      vote.save
    end

  end

  (from_date..to_date).each do |d|
    tracks = search_tracks
    song = random_track(tracks)
    user = random_user
    song_found = Song.find_by_spotify_id(song.id)
    if song_found == nil
      new_song = process_song(song, user, d)
      Vote.vote(new_song, user, d)
    elsif song_found
      Vote.vote(song_found, user, d)
    end
    User.all.map do |user| 
      user.vote_count = 5
      user.save
    end
  end

end


class Playlist < ActiveRecord::Base
  has_many :songs

  def start_time
    self.created_at - 1.week
  end

  def end_time
    self.created_at
  end

  def self.create_playlist(date)
    playlist = Playlist.create(created_at: date)
    songs = Song.where(created_at: playlist.start_time..playlist.end_time)
    songs.each {|song| song.update_attributes(playlist_id: playlist.id)}
  end
end

from_date = DateTime.new(2015, 1, 2)
to_date   = DateTime.new(2015, 2, 28)
until from_date >= to_date
  Playlist.create_playlist(from_date)
  from_date += 7.days
end


