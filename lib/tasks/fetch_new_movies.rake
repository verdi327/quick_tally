desc "fetches in theaters movies from rotten tomatoes and sets the top 20 to in_theaters"
task :fetch_new_movies => :environment do
  counter = 0
  in_theater_counter = 0
  builder = InTheaterMovies.new
  builder.fetch
  movies = builder.results
  unless movies.empty?
    Movie.mark_all_as_out_of_theater
    movies.each_with_index do |movie, index|
      found_movie = Movie.find_by_title(movie["title"])
      if found_movie
        if index <= 25
          puts "setting #{found_movie.title} as still in theaters"
          found_movie.mark_as_in_theaters
        else
          puts "found #{found_movie.title} - NOT adding to db or marking as in theaters"
        end
      else
        puts "Adding new movie: #{movie['title']}"
        new_movie = Movie.create(
          title:         movie["title"],
          description:   movie["synopsis"],
          critics_score: movie["ratings"]["critics_score"],
          rating:        movie["mpaa_rating"],
          runtime:       movie["runtime"],
          thumbnail_img: movie["posters"]["thumbnail"],
          profile_img:   movie["posters"]["profile"]
        )
        if index < 25
          new_movie.mark_as_in_theaters
          in_theater_counter += 1
          puts "===> setting the above as in theaters"
        end
        counter += 1
      end
    end
  end
  puts ""
  puts "Added #{counter} new movies!"
  puts "Set #{in_theater_counter} movies as in theaters"
end