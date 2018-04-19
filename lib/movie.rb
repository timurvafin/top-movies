require "kp_api"
require "uri"

class Movie
  attr_reader :itunes_movie

  def initialize(itunes_movie)
    @itunes_movie  = itunes_movie
  end

  def name
    itunes_movie["name"]
  end

  def rating
    kinopoisk_movie_details[:rating]
  end

  def description
    kinopoisk_movie_details[:description]
  end

  def kinopoisk_link
    "https://www.kinopoisk.ru/film/#{kinopoisk_movie[:id]}"
  end

  def rutracker_link
    "https://rutracker.org/forum/tracker.php?f=1936,313,930&nm=#{URI.escape(name)}"
  end

  def artwork
    itunes_movie["artworkUrl100"]
  end

  private

  def kinopoisk_movie_details
    @kinopoisk_movie_details ||= KpApi::Film.new(kinopoisk_movie[:id]).view
  end

  def kinopoisk_search_name
    name.gsub(/[,:]/, "")
  end

  def kinopoisk_search
    @kinopoisk_search ||= KpApi::FilmSearch.new(kinopoisk_search_name)
  end

  def kinopoisk_results
    return [] unless kinopoisk_search.found?
    kinopoisk_search.view
  end

  def kinopoisk_movie
    @kinopoisk_movie ||= kinopoisk_results.first
  end
end
