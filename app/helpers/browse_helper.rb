module BrowseHelper

  def report_relevant_totals
    if @city_count.nil? and @genre.nil?
      return ""
    elsif @city_count.nil?
      return "There #{are_is(@genre_count)} #{pluralize(@genre_count, 'band')} in that genre"
    elsif @genre.nil?
      return "There #{are_is(@city_count)} #{pluralize(@city_count, 'band')} in #{@city}"
    else
      return "There #{are_is(@genre_city_count)} #{@genre_city_count} #{genre_bands(@genre, @genre_city_count)} among the #{pluralize(@city_count, 'band')} in #{@city}"
    end
  end

  def genre_bands(genre, count)
    count == 1 ? "#{genre} band" : "#{genre} bands"
  end

  def are_is(count)
    count == 1 ? "is" : "are"
  end

end
