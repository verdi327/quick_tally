class NewRentalMovies < MovieFetcher
  attr_reader :url

  def initialize
    super
    @url = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json"
  end

  def fetch
    begin
      response = connection.get do |req|
        req.params['page_limit'] = 50
        req.params['apikey'] = api_key
      end
      JSON.parse(response.body)["movies"]
    rescue => e
      Rails.logger.error e
      []
    end
  end

end