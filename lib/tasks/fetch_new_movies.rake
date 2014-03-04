desc "fetches the newest movies in theater from rotten tomatoes"
task :fetch_new_movies => :environment do
  counter = 0
  movies = MovieFetcher.new.in_theaters
  unless movies.empty?
    movies.each do |movie|
      already_exist = Movie.find_by_title(movie["title"])
      unless already_exist
        puts "Adding new movie: #{movie['title']}"
        Movie.create(
          title:         movie["title"],
          description:   movie["synopsis"],
          critics_score: movie["ratings"]["critics_score"],
          rating:        movie["mpaa_rating"],
          runtime:       movie["runtime"],
          thumbnail_img: movie["posters"]["thumbnail"],
          profile_img:   movie["posters"]["profile"]
        )
        counter += 1
      end
    end
  end
  puts ""
  puts "Added #{counter} new movies!"
end