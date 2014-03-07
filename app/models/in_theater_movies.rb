class InTheaterMovies < MovieFetcher
  attr_reader :url

  def initialize
    super
    @url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json"
    @results = []
  end

  def results
    @results.flatten.uniq {|result| result["id"]}
  end

  def fetch
    begin
      1.upto(5) do |page|
        response = connection.get do |req|
          req.params['page_limit'] = 50
          req.params['apikey'] = api_key
          req.params['page'] = page
        end
        result = JSON.parse(response.body)["movies"]
        puts "found #{result.size} movies" if result
        @results << result if result
        sleep 1
      end
    rescue => e
      Rails.logger.error e
      []
    end
  end

end