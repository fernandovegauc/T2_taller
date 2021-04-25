class AlbumsController < ApplicationController
  def create
    return render status: 400 if (params[:name].blank? || params[:genre].blank?)

    search_artist = Artist.find_by id: params[:artist_id]
    return render status: 422 if search_artist.blank?

    search_album = Album.find_by id: encoding("#{params[:name]}:#{params[:artist_id]}") 
    return render json: search_album, status: 409 if search_album.present?
     
    album = Album.new
    album.id = encoding("#{params[:name]}:#{params[:artist_id]}")
    album.artist_id = params[:artist_id]
    album.artist_url = "https://t2tallerintegracion.herokuapp.com/artists/#{params[:artist_id]}"
    album.tracks_url = "https://t2tallerintegracion.herokuapp.com/artists/#{album.id}/tracks"
    album.self_url = "https://t2tallerintegracion.herokuapp.com/albums/#{album.id}"
    album.name = params[:name]
    album.genre = params[:genre]
    album.save
    render json: album, status: 201   
  end

  def index
    return render json: Album.all, status: 200 if params[:artist_id].blank?

    return render status: 404 if Artist.find_by(id: params[:artist_id]).blank?

    render json: Album.where(artist_id: params[:artist_id]), status: 200
  end
  
  def show
    album = Album.find_by id: params[:id]
    if album.present?
      render json: album, status:  200 
    else
      render  status: 404    
    end
  end

  def play
    album = Album.find_by id: params[:id]
    return render status: 404 if album.blank?

    album.tracks.each do |track|
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
