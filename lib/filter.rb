require "movie"

class Filter
  attr_reader :itunes_movies, :min_rating

  def initialize(itunes_movies, min_rating: 7)
    @itunes_movies = itunes_movies
    @min_rating = min_rating
  end

  def all_movies
    itunes_movies.map { |m| Movie.new(m) }
  end

  def top_movies
    all_movies
      .reject { |movie| movie.rating < min_rating }
      .sort_by { |movie| movie.rating }
      .reverse
  end
end
