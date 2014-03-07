class MovieFetcher
  attr_reader :api_key

  def initialize
    @api_key = ENV["ROTTEN_TOMATOES_KEY"]
  end

  def connection
    @conn ||= Faraday.new(url)
  end

end