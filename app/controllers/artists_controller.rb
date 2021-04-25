class ArtistsController < ApplicationController
  
  def create
    return render json: {}, status: 400 if (params[:name].blank? || params[:age].blank? )
    artist = Artist.find_by(id: encoding(params[:name]))
    return render json: artist, status: 409 if artist.present?
    
    
    
    artist = Artist.new
    artist.id = encoding(params[:name])
    artist.albums_url = "https://spotifyapi1997.herokuapp.com/artists/#{artist.id}/albums"
    artist.tracks_url = "https://spotifyapi1997.herokuapp.com/artists/#{artist.id}/tracks"
    artist.self_url = "https://spotifyapi1997.herokuapp.com/artists/#{artist.id}"
    artist.name = params[:name]
    artist.age = params[:age]
    
    
    artist.save
    response = {
      id:  artist.id, name: artist.name , 
      age: artist.age, albums:  artist.albums_url,
       tracks:  artist.tracks_url, self: artist.self_url }
    render json: response, status: 201
    

  end

  def index
    artists = Artist.all
    response = []
    artists.each do |element|
      response << {id: element.id, name:  element.name , age: element.age, albums: element.albums_url, tracks: element.tracks_url, self: element.self_url }
    end
    
    render json: response, :status => 200
  end

  def show
    artist = Artist.find_by id: params[:id]
    
    
   
    if artist.present?
      response = {id: artist.id, name:  artist.name ,
        age: artist.age, albums: artist.albums_url, tracks: artist.tracks_url, self: artist.self_url }
      render json: response, status:  200

      
    else
      render json:  status: 404
      
    end


  end

  def play
    artist = Artist.find_by id: params[:id]
    return render status: 404 if artist.blank?
    artist.albums.each do |album|
      album.tracks.each do |track|
        track.update(times_played: track.times_played + 1)
      end 
    end
    render status: 200

  end

  def destroy
    artist = Artist.find_by id: params[:id]
    
    

    if artist.present?
      artist.destroy
      render status: 202
      
    else
      render status: 404
      
    end
    

  end

end
