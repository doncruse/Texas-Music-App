class BrowseController < ApplicationController

  def index
    
    @city_options = Band.select("DISTINCT city").map(&:city).sort
    @genre_options = Genre.select("DISTINCT name").map(&:name).sort
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
      @result = Band.where(:city => @city).order("name ASC").joins(:genres) & Genre.where("genres.name = ?", @genre)
    elsif @city
      @result = Band.where(:city => @city).order("name ASC")
    elsif @genre
      @result = Band.order("name ASC").joins(:genres) & Genre.where(:name => @genre)
    end
    
  end

  def show
  end

end