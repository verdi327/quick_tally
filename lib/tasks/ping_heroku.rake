namespace :utility do
  desc "pings heroku server so we have no sad visitors"
  task :ping_heroku => :environment do
    conn = Faraday.new("http://quicktally.herokuapp.com")
    conn.get
  end
end