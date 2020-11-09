require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def validword?(proposition)
    url = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{proposition}").read)
    url['found'] # will return true or false because validword+?
  end

  def fitletters?(proposition, letters)
    array = []
    proposition.each_char do |char|
      array << char if letters.include?(char)
    end
    array.length == proposition.length
  end

  def score
    @letters = params[:letters]
    @proposition = params[:word]
    if fitletters?(@proposition, @letters) && validword?(@proposition)
      @score = "Congratulations! #{@proposition.upcase} is a valid Enlish word."
    elsif fitletters?(@proposition, @letters)
      @score = "Sorry but #{@proposition.upcase} does not seem to be a valid English word..."
    else
      @score = "Sorry but #{@proposition.upcase} can't be built out of #{@letters.upcase}."
    end
  end
end
