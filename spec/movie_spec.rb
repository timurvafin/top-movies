require "movie"

RSpec.shared_examples "a movie" do |name, rating|
  let(:movie) { Movie.new("name" => name) }

  context "with `#{name}` name" do
    it "has name" do
      expect(movie.name).to eql(name)
    end

    it "has rating" do
      expect(movie.rating).to eql(rating)
    end

    it "has description" do
      expect(movie.description).to be_present
    end
  end
end

RSpec.describe Movie do
  {
    "Три рекламных щита на границе Эббинга, Миссури" => 8.2,
    "Место встречи" => 7.4

  }.each do |name, rating|
    it_behaves_like "a movie", name, rating
  end
end
