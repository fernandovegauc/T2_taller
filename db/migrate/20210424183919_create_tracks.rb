class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks , id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.float :duration
      t.integer :times_played
      t.string :album_url
      t.string :self_url
      t.string :artist_url
      t.references :album, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
