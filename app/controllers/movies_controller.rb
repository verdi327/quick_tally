class MoviesController < ApplicationController
  def index
    @movies = Movie.in_theaters
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
