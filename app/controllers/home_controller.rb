class HomeController < ApplicationController
  def index
    @movies = Movie.search_full_text("Lego")
  end
end