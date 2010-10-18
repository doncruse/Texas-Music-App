class Genre < ActiveRecord::Base
  has_and_belongs_to_many :bands, :join_table => "band_genres"

  def self.in_city(city)
    joins(:bands) & Band.in_city(city)
  end

  def self.unique_in_city(city)
    in_city(city).map(&:name).uniq
  end

  def self.count_in_city(city)
    counts = Hash.new
    in_city(city).each { |x| counts.has_key?(x.name) ? (counts[x.name] += 1) : (counts[x.name] = 1) }
    counts
  end
  
  def self.scaled_count_in_city(city)
    city_size = Band.in_city(city).count
    temp = count_in_city(city)
    return temp if city_size <= 10
    city_size = 100 if city_size > 100
    temp.keys.each { |x| temp[x] = [5, ((temp[x] / (city_size / 10)).to_i + 1) ].min }
    temp
  end

  def self.bands_with(name)
    Band.joins(:genres) & where("genres.name = ?", name)
  end

  def self.band_count
    joins(:bands).count
  end
end