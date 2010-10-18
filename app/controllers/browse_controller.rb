class BrowseController < ApplicationController
  before_filter :preload_dropdown_options, :only => [:index, :search, :city]

  def index
    @city = nil
    @genre = nil
    @search_term = nil
    return unless request.post?
    
    if params[:genre] != ""
      @genre = params[:genre]
    end
    if params[:city] != ""
      @city = params[:city]
    end
    if @city and @genre
      @result = Band.in_city(@city).order("name ASC").joins(:genres) & Genre.where("genres.name = ?", @genre)
    elsif @city
      @result = Band.in_city(@city).order("name ASC")
    elsif @genre
      @result = Band.with_genre(@genre).order("name ASC")
    end
  end

  def search
    unless params[:search_term] and (params[:search_term] != "")
      redirect_to '/'
      return
    end
    @search_term = params[:search_term]
    @result = Band.where("name LIKE ?", "%#{params[:search_term]}%")
    @city = nil
    @genre = nil
    render :action => :index
  end

  # First, they select the city
  # That brings up a set of genre tags AND all the bands for the city
  # If they select a genre, then it reloads this page limited to that city and that genre
  #     With that genre tag highlighted in the set of genre tags 

  def city
    @city = nil
    @genre = nil
    if params[:city] != ""
      @city = params[:city]
    end
    if params[:genre] != ""
      @genre = params[:genre]
    end
    return unless @city
    @genre_cloud = Genre.scaled_count_in_city(@city)
    if @genre
      @result = Band.where(:city => @city).order("name ASC").joins(:genres) & Genre.where("genres.name = ?", @genre)
    else
      @result = Band.where(:city => @city).order("name ASC").includes(:band_links, :genres)
    end
    
    @city_count = Band.where(:city => @city).count
    @genre_city_count = @result.count if @genre
  end

  def show
  end

protected

  def preload_dropdown_options
    @city_options = Band.select("DISTINCT city").map(&:city).sort
    @genre_options = Genre.select("DISTINCT name").map(&:name).sort
  end

end