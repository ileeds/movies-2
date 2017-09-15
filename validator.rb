require_relative 'ratings.rb'

# takes two instances of Ratings, one representing a base set and the other representing a test set
class Validator

  # runs through all the entries in the test set and see what ratings would be predicted vs. which ones were given
  # computes statistics about the prediction: how many predictions were exact, off by one, etc.
  # also the mean and stdev of the difference between the two
  def self.validate(ratings_base, ratings_test)
    @ratings_base, @ratings_test, differences = ratings_base, ratings_test, Array.new(5, 0)

    ratings_test.users.each do |user, movies|
      find_diff(user, movies, differences)
    end
    average = Validator.average_diff(differences)
    Validator.stdev_diff(differences, average)
  end

  def self.find_diff(user, movies, differences)
    movies.each do |movie|
      predicted = @ratings_base.predict(user, movie[0])
      diff = (predicted - movie[1]).abs
      differences[diff]+=1
    end
    differences
  end

  def self.average_diff(differences)
    avg, total = 0.0, 0.0
    differences.each_with_index do |value, amount|
      avg += value*amount
      total +=value
    end
    avg/total
  end

  def self.stdev_diff(differences, average)
    arr = Array.new
    differences.each_with_index do |value, amount|
      value.times do
        arr.push((amount-average) ** 2)
      end
    end
    Math.sqrt(arr.reduce(:+).to_f / arr.size)
  end

end
