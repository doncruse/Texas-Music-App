class Band < ActiveRecord::Base
  has_many :band_links
  has_and_belongs_to_many :genres, :join_table => "band_genres"
end