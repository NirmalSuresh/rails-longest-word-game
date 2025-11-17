require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]

    if !can_be_built?(@word, @letters)
      @result = "❌ The word cannot be built out of the grid."
    elsif !english_word?(@word)
      @result = "❌ The word is not an English word."
    else
      @result = "✅ Congratulations! #{@word.upcase} is a valid word!"
    end
  end

  private

  def can_be_built?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    json = URI.open(url).read
    result = JSON.parse(json)
    result["found"]
  end
end
