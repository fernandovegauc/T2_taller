class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :album_id, :times_played
  attribute :artist_url, key: :artist
  attribute :self_url, key: :self
  attribute :album_url, key: :album
end
