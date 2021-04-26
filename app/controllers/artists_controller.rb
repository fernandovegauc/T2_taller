class ArtistsController < ApplicationController
  
  def create
    return render json: {}, status: 400 if (params[:name].blank? || params[:age].blank? )

    artist = Artist.find_by(id: encoding(params[:name]))
    return render json: artist, status: 409 if artist.present?

    artist = Artist.new
    artist.id = encoding(params[:name])
    artist.albums_url = "https://t2tallerintegracion.herokuapp.com/artists/#{artist.id}/albums"
    artist.tracks_url = "https://t2tallerintegracion.herokuapp.com/artists/#{artist.id}/tracks"
    artist.self_url = "https://t2tallerintegracion.herokuapp.com/artists/#{artist.id}"
    artist.name = params[:name]
    artist.age = params[:age]
    artist.save
    render json: artist, status: 201
  end

  def index
    render json: Artist.all, status: 200
  end

  def show  
    if Artist.find_by(id: params[:id]).present?
      render json: Artist.find_by(id: params[:id]), status:  200
    else
      render status: 404      
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
      render status: 204     
    else
      render status: 404   
    end
  end
end
