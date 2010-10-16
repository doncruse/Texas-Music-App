class BrowseController < ApplicationController

  def index
    
    @city_options = Band.select("DISTINCT city").map(&:city).sort
    @genre_options = Genre.all.map(&:name).sort
    @city = nil
    @genre = nil
    
    return unless request.post?
    
    if params[:genre] != ""
      @genre = params[:genre]
    end
    if params[:city] != ""
      @city = params[:city]
    end
    
    if @city and @genre
      @result = Band.find_all_by_city(@city).select { |x| x.genres.map(&:name).include?(@genre)}
    elsif @city
      @result = Band.find_all_by_city(@city)
    elsif @genre
      @result = Genre.find_by_name(@genre).bands
    end
    
  end

  def show
  end

end