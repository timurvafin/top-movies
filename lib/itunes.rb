require "httparty"

class Itunes
  include HTTParty
  base_uri "https://rss.itunes.apple.com/api/v1"

  def initialize(language: "ru", format: "json", limit: 10)
    @language = language
    @format = format
    @limit = limit
  end

  def top_movies
    self.class.get("/#{@language}/movies/top-movies/all/#{@limit}/explicit.#{@format}")["feed"]["results"]
  end
end
