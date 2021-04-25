class AlbumsController < ApplicationController
  def create
    search_artist = Artist.find_by id: params[:artist_id]
    search_album = Album.find_by id: encoding(params[:name])
    
    return render status: 422 if search_artist.blank?
    return render json: search_album, status: 409 if search_album.present?
    return render status: 400 if params[:name].blank? || params[:genre].blank? 

    album = Album.new
    album.id = encoding(params[:name])
    album.artist_id = params[:artist_id]
    album.artist_url = "https://spotifyapi1997.herokuapp.com/artists/#{params[:artist_id]}"
    album.tracks_url = "https://spotifyapi1997.herokuapp.com/artists/#{album.id}/tracks"
    album.self_url = "https://spotifyapi1997.herokuapp.com/albums/#{album.id}"
    album.name = params[:name]
    album.genre = params[:genre]

    
    album.save
    response = {id: album.id, name: album.name , genre: album.genre, self:  album.self_url,
       tracks: album.tracks_url, artist:  album.artist_url }
    render json: response, status: 201

    
    

   
  end

  def index
    albums = Album.all
    response = []
    albums.each do |element|
      response << {id: element.id, name:  element.name , genre: element.genre, self:  element.self_url,
         tracks:  element.tracks_url, artist:  element.artist_url }
    end
    
    render json: response, :status => 200
  end
  

  def show
    album = Album.find_by id: params[:id]
   
    if album.present?
      response = {
        id:  album.id, name: album.name , 
        genre: album.genre, artist:  album.artist_url,
         tracks:  album.tracks_url, self: album.self_url }
      render json: response status:  200

      
    else
      render  :status => 404
      
    end
  end

  def play
    album = Album.find_by id: params[:id]
    return render status: 404 if album.blank?
    album.each do |track|
      track.update(times_played: track.times_played + 1)
      end 
    
    render status: 200
  end

  def destroy
    album = Album.find_by id: params[:id]

    if album.present?
      album.destroy
      render status: 202
      
    else
      render status: 404
      
    end
  end
end
