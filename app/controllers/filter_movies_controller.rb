class FilterMoviesController < ApplicationController
  def index
  end

  def create
    @movies = Movie.search_full_text(params[:query]).limit(20).order(critics_score: :desc)
    render :index
  end
end
