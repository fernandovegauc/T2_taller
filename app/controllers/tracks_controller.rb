class TracksController < ApplicationController
  def create
    search_album = Album.find_by id: params[:album_id]
   
    
    
    return render json: {}, status: 400 if (params[:name].blank? || params[:duration].blank? )
    track = Track.find_by(id: encoding(params[:name]))
    return render json: track, status: 409 if track.present?
    return render status: 422 if search_album.blank?
    
    
    
    track = Track.new
    track.id = encoding(params[:name])
    track.album_url = "https://spotifyapi1997.herokuapp.com/albums/#{params[:album_id]}"
    track.artist_url = "https://spotifyapi1997.herokuapp.com/artists/#{search_album.artist_id}"
    track.self_url = "https://spotifyapi1997.herokuapp.com/tracks/#{track.id}"
    track.duration = params[:duration]
    track.times_played = 0
    track.album_id = params[:album_id]
    track.name = params[:name]
    
    track.save
    response = {
      id:  track.id, name: track.name , 
      times_played: track.times_played, album:  track.album_url,
       artist:  track.artist_url, self: track.self_url }
    render json: response, status: 201
    

    end
  def index
    tracks = Track.all
    return render json: tracks
    response = []
    tracks.each do |track|
      response << {
        id:  track.id, name: track.name , 
        times_played: track.times_played, album:  track.album_url,
         artist:  track.artist_url, self: track.self_url }
    end
    
    render json: response, :status => 200
  end

  def show
    track = Track.find_by id: params[:id]
    response = {
      id:  track.id, name: track.name , 
      times_played: track.times_played, album:  track.album_url,
       artist:  track.artist_url, self: track.self_url }
   
    if track.present?
      render json: response, status:  200

      
    else
      render json: response, :status => 404
      
    end
  end

  def play
    track = Track.find_by id: params[:id]
    return render status: 404 if track.blank?
    track.update(times_played: track.times_played + 1)
    render status: 200
  end

  def destroy
    track = Track.find_by id: params[:id]

    if track.present?
      track.destroy
      render status: 202
      
    else
      render status: 404
      
    end
  end
end
