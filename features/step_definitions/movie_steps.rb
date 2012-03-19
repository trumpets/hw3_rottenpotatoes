# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!([:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date]])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  match = /#{e1}.*#{e2}/m =~ page.body
  assert match
end

Then /I should see all of the movies/ do
  actual = all("table#movies tr").size - 1
  actual.should == Movie.count
end

Then /I should not see any movies/ do
  actual = all("table#movies tr").size - 1
  actual.should == 0
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  split_ratings = rating_list.split(', ')
  split_ratings.each do |r|
    if uncheck == "un"
    	uncheck("ratings_" + r)
    else
        check("ratings_" + r)
    end
  end
end
