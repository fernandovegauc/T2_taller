class ArtistSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :age, :albums_url, :tracks_url, :self_url
end
