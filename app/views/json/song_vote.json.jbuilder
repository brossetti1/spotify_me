json.vote do
	json.vote_type @vote.vote_type
end

json.song do
	json.song_id @song.id
	json.user_id @song.user_id
	json.artist @song.artist
	json.title @song.title
	json.spotify_id @song.spotify_id	
	json.album @song.album
end
	