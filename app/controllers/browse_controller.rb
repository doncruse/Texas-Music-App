class BrowseController < ApplicationController
  autocomplete :band, :name, :full => true
  before_filter :preload_dropdown_options, :only => [:index, :search]
  
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
      @result = Band.where(:city => @city).order("name ASC").joins(:genres) & Genre.where("genres.name = ?", @genre)
    elsif @city
      @result = Band.where(:city => @city).order("name ASC")
    elsif @genre
      @result = Band.order("name ASC").joins(:genres) & Genre.where(:name => @genre)
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

  def show
  end

protected

  def preload_dropdown_options
    @city_options = Band.select("DISTINCT city").map(&:city).sort
    @genre_options = Genre.select("DISTINCT name").map(&:name).sort
  end

end