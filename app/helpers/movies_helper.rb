module MoviesHelper
  def determine_viewer_style(movie)
    case movie.viewer_consensus
    when Movie::SEE_AT_THEATER then "success"
    when Movie::SEE_AT_HOME then "warning"
    when Movie::DONT_SEE then "danger"
    end
  end

  def determine_critic_style(movie)
    score = movie.critics_score
    if score <= 100 && score > 75
      "success"
    elsif score <= 75 && score > 50
      "warning"
    else
      "danger"
    end
  end
end
