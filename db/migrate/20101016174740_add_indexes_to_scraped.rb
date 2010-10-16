class AddIndexesToScraped < ActiveRecord::Migration
  def self.up
    add_index :bands, :city
    add_index :genres, :name
    add_index :band_genres, :band_id
    add_index :band_genres, :genre_id
    add_index :band_links, :band_id
  end

  def self.down
    remove_index :band_links, :band_id
    remove_index :band_genres, :genre_id
    remove_index :band_genres, :band_id
    remove_index :genres, :name
    remove_index :bands, :city
  end
end
