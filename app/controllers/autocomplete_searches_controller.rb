class AutocompleteSearchesController < ApplicationController
  respond_to :js

  def index
    @listings = Band.limit(10).search_for_name(params[:search_term])
  end

end
