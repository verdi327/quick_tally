desc "fetches newly released movies from rotten tomatoes"
task :fetch_new_rentals => :environment do
  counter = 0
  movies = NewRentalMovies.new.fetch
  unless movies.empty?
    movies.each do |movie|
      found_movie = Movie.find_by_title(movie["title"])
      if found_movie
        puts "already have #{found_movie.title} in database"
      else
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