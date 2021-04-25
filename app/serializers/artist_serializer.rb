class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :age
  attribute :albums_url, key: :albums
  attribute :self_url, key: :self
  attribute :tracks_url, key: :tracks
  

end
