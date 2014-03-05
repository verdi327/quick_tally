desc "fetches the newest movies in theater from rotten tomatoes"
task :fetch_new_movies => :environment do
  counter = 0
  Movie.mark_all_as_out_of_theater
  movies = MovieFetcher.new.in_theaters
  unless movies.empty?
    movies.each do |movie|
      found_movie = Movie.find_by_title(movie["title"])
      if found_movie
        puts "setting #{found_movie.title} as still in theaters"
        found_movie.mark_as_in_theaters
      else
        puts "Adding new movie: #{movie['title']}"
        Movie.create(
          title:         movie["title"],
          description:   movie["synopsis"],
          critics_score: movie["ratings"]["critics_score"],
          rating:        movie["mpaa_rating"],
          runtime:       movie["runtime"],
          thumbnail_img: movie["posters"]["thumbnail"],
          profile_img:   movie["posters"]["profile"],
          in_theaters:   true
        )
        counter += 1
      end
    end
  end
  puts ""
  puts "Added #{counter} new movies!"
end