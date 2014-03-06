class Movie < ActiveRecord::Base
  SEE_AT_THEATER = "See At Theater"
  SEE_AT_HOME    = "Wait For NetFlix"
  DONT_SEE       = "Don't Waste Your Time"

  include PgSearch

  pg_search_scope :search_full_text, :against => {
    :title => 'A',
    :description => 'B'
  }

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

  def add_rating(rating)
    case rating
    when SEE_AT_THEATER then update_attribute :positive_count, (positive_count + 1)
    when SEE_AT_HOME then update_attribute :neutral_count, (neutral_count + 1)
    when DONT_SEE then update_attribute :negative_count, (negative_count + 1)
    end
  end

  def insufficient_votes?
    total_votes < vote_threshold
  end

  def votes_until_live
    vote_threshold - total_votes
  end

  private

  def viewer_results
    {SEE_AT_THEATER => positive_count, SEE_AT_HOME => neutral_count, DONT_SEE => negative_count}
  end

  def vote_threshold
    10
  end
end
