require "open-uri"
require "json"

puts "Cleaning all movies and lists..."
List.destroy_all
Movie.destroy_all

url = URI("https://tmdb.lewagon.com/movie/top_rated")
response_serialized = URI.parse(url).read
response = JSON.parse(response_serialized)

puts "Seeding with movies from tmdb..."
response["results"].each do |movie|
  movie_params = {}
  movie_params[:title] = movie["title"]
  movie_params[:overview] = movie["overview"]
  movie_params[:poster_url] = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
  movie_params[:rating] = movie["vote_average"].to_f
  Movie.create!(movie_params)
end

puts "Seeding some lists..."
List.create!(name: "My top faves evaa!")
List.create!(name: "For that rainy weekend")

puts "Seeding some bookmarks..."
Bookmark.create!(comment: "Def my top pick", movie_id: Movie.first.id, list_id: List.first.id)
Bookmark.create!(comment: "My second go to", movie_id: Movie.where(title: "The Shawshank Redemption").first.id, list_id: List.where(name: "For that rainy weekend").first.id)
Bookmark.create!(comment: "Great one", movie_id: Movie.last.id, list_id: List.last.id)

puts "Done!"
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
