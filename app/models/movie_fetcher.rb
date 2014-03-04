class MovieFetcher
  attr_reader :url, :api_key

  def initialize
    @url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json"
    @api_key = ENV["ROTTEN_TOMATOES_KEY"]
  end

  def in_theaters
    begin
      response = connection.get {|req| req.params['apikey'] = api_key}
      JSON.parse(response.body)["movies"]
    rescue => e
      Rails.logger.error e
      []
    end
  end

  private

  def connection
    @conn ||= Faraday.new(url)
  end

end