# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  # db = Movie.new ## Adding movies to the database.
   # movie.save
 #  dbMovie = Movie.new
  # dbMovie.title(movie.title)
   #....
   #dbMovie.save
    Movie.create(movie)
  end
 # fail "Unimplemented"
 @movies = Movie.all
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |m1, m2|
  #  ensure that that m1 occurs before m2.
 

  expect(page.body.index(m1)).to be < page.body.index(m2) ## m1 is less than m2 on the page.
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   rating_list.split(", ").each do |rating| ## Split all of the ratings given by a comma.
 
    check("ratings[#{rating}]")
  end
 # fail "Unimplemented"
end

When /I uncheck the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating| 

       uncheck("ratings[#{rating}]")
  end
end




Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table

 expect(page).to have_selector('tbody tr', count: Movie.count) ## Expect the page to have the same amount of movies as is in the database.
 
end
