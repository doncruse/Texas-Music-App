class BrowseController < ApplicationController
  before_filter :preload_dropdown_options, :only => [:index, :search]
  before_filter :preload_city_dropdown_only, :only => [:city]

  def index
    @city = nil
    @genre = nil
    @search_term = nil
    return unless request.post?
    
    process_city_and_genre_params
    if @city and @genre
      redirect_to :action => :city, :city => @city, :genre => @genre
      return
    elsif @city
      redirect_to :action => :city, :city => @city
      return
    elsif @genre
      @result = Band.with_genre(@genre).order("name ASC")
      @genre_count = @result.count
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

  def filter
    process_city_and_genre_params
    if @city and @genre
      redirect_to :action => :city, :city => @city, :genre => @genre
      return
    elsif @city
      redirect_to :action => :city, :city => @city
      return
    elsif @genre
      redirect_to :action => :index, :genre => @genre, "_method" => :post
      return
    else
      redirect_to :action => :index
      return
    end
  end

  # First, they select the city
  # That brings up a set of genre tags AND all the bands for the city
  # If they select a genre, then it reloads this page limited to that city and that genre

  def city
    process_city_and_genre_params
    return unless @city
    @genre_cloud = Genre.scaled_count_in_city(@city)
    if @genre
      @result = Band.where(:city => @city).order("name ASC").joins(:genres) & Genre.where("genres.name = ?", @genre)
    else
      @result = Band.where(:city => @city).order("name ASC").includes(:band_links, :genres)
    end
    @city_count = Band.where(:city => @city).count
    @genre_city_count = @result.count if @genre
    cache_this_page(43200) # 12 hours
  end

  def show
  end

protected

  def cache_this_page(ttl = 3600)
    response.headers['Cache-Control'] = "public, max-age=#{ttl}"
  end

  def process_city_and_genre_params
    @city = nil
    @genre = nil
    if params[:city] != ""
      @city = params[:city]
    end
    if params[:genre] != ""
      @genre = params[:genre]
    end
  end

  def preload_dropdown_options
    @city_options = Band.select("DISTINCT city").map(&:city).sort
    @genre_options = Genre.select("DISTINCT name").map(&:name).sort
  end
  
  def preload_city_dropdown_only
    @city_options = Band.select("DISTINCT city").map(&:city).sort
  end

end