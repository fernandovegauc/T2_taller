class TracksController < ApplicationController
  def create
    return render json: {}, status: 400 if (params[:name].blank? || params[:duration].blank? )

    search_album = Album.find_by id: params[:album_id]
    return render status: 422 if search_album.blank?

    track = Track.find_by(id: encoding("#{params[:name]}:#{params[:album_id]}"))
    return render json: track, status: 409 if track.present?
    
    track = Track.new
    track.id = encoding("#{params[:name]}:#{params[:album_id]}")
    track.album_url = "https://t2tallerintegracion.herokuapp.com/albums/#{params[:album_id]}"
    track.artist_url = "https://t2tallerintegracion.herokuapp.com/artists/#{search_album.artist_id}"
    track.self_url = "https://t2tallerintegracion.herokuapp.com/#{track.id}"
    track.duration = params[:duration]
    track.times_played = 0
    track.album_id = params[:album_id]
    track.name = params[:name]
    track.save
    render json: track, status: 201
  end
  
  def index
    if params[:artist_id].present?
      artist = Artist.find_by(id: params[:artist_id])
      return status: 404 if artist.blank?

      render json: artist.albums.map { |album| album.tracks }.flatten, stauts: :ok
    elsif params[:album_id].present?
      album = Album.find_by(id: params[:album_id])
      return status: 404 if album.blank?

      render json: album.tracks, stauts: :ok
    else
      render json: Track.all, status: :ok
    end
  end

  def show
    track = Track.find_by id: params[:id]
    if track.present?
      render json: track, status:  200  
    else
      render  status:  404
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
