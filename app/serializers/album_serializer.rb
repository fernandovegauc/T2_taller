class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :genre, :artist_id
  attribute :artist_url, key: :artist
  attribute :self_url, key: :self
  attribute :tracks_url, key: :tracks
end
