class RatingsController < ApplicationController
  before_action :require_correct_rating, only: [:create]

  def create
    movie = Movie.find_by_id(params[:movie_id])
    if movie.add_rating(rating)
      flash[:success] = "Woot! #{movie.title} rated"
      redirect_to movies_path
    else
      flash[:error] = "Curses! Try again"
      redirect_to movie_path(movie)
    end
  end

  private

  def require_correct_rating
    if rating.blank? || !approved_rating?
      flash[:error] = "A rating must be of the three provided values below"
      redirect_to movie_path(params[:movie_id]) and return
    end
  end

  def rating
    params[:rating].strip
  end

  def approved_rating?
    rating == Movie::SEE_AT_THEATER ||
    rating == Movie::SEE_AT_HOME ||
    rating == Movie::DONT_SEE
  end
end
