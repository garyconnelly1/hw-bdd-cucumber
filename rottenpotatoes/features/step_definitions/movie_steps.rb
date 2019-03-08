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
  #  ensure that that e1 occurs before e2.
 
  regexp = /{m1}.*{m2}/m 
  page.body.should =~ regexp
  
  
  
 # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   rating_list.split(", ").each do |rating| ## Split all of the ratings given by a comma.
    #####  step %Q{I check "ratings_#{rating}"}
    check("ratings[#{rating}]")
  end
 # fail "Unimplemented"
end

When /I uncheck the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating| 
#####      step %Q{I uncheck "ratings_#{rating}"}
       uncheck("ratings[#{rating}]")
  end
end




Then /^I should see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|  
     step %Q{I should see "#{rating}"} ## Trying the samw way as above.
  end
 end
 
 Then /^I should not see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|
    (page.body=~/\Arating\z/) == nil 
  end
end

When(/^I check all movies$/) do
  @movies.pluck(:rating).uniq.each do |rating| 
    step %Q{I check "ratings_#{rating}"}
  end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
#####   @movies.each do |movie|
#####    step %Q{I should see "#{movie.title}"}
#####  end
 expect(page).to have_selector('tbody tr', count: Movie.count)
  #fail "Unimplemented"
end
