class Band < ActiveRecord::Base
  has_many :band_links
  has_and_belongs_to_many :genres, :join_table => "band_genres"

  def self.in_city(city)
    where(:city => city)
  end
  
  def self.with_genre(name)
    self.joins(:genres) & Genre.where("genres.name = ?", name)
  end
end