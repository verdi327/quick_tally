class Movie < ActiveRecord::Base
  SEE_AT_THEATER = "See At Theater"
  SEE_AT_HOME    = "See At Home"
  DONT_SEE       = "Don't See"

  scope :in_theaters, -> {where(in_theaters: true).order(critics_score: :desc)}

  def self.mark_all_as_out_of_theater
    all.each {|movie| movie.mark_as_out_of_theater}
  end

  def mark_as_in_theaters
    update_attribute :in_theaters, true
  end

  def mark_as_out_of_theater
    update_attribute :in_theaters, false
  end

  def total_votes
    positive_count + neutral_count + negative_count
  end

  def viewer_consensus
    viewer_results.sort_by {|opinion, count| -count }.flatten.first
  end

  private

  def viewer_results
    {SEE_AT_THEATER => positive_count, SEE_AT_HOME => neutral_count, DONT_SEE => negative_count}
  end
end
