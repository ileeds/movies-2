require_relative 'ratings.rb'
require_relative 'validator.rb'

# instantiates and invokes ratings and validator classes
class Control

  def run(filename)
    ratings_base = Ratings.initialize_base(filename)
    ratings_test = Ratings.initialize_test(filename)
    diff, average, stdev = Validator.validate(ratings_base, ratings_test)
    show_stats(diff, average, stdev)
  end

  # displays statistics from validation
  def show_stats(diff, average, stdev)
    puts 'Average error is: ' + average.to_s
    puts 'Standard deviation of the error is: ' + stdev.to_s
    (0..4).each do |off|
      puts 'Number of predictions ' + off.to_s + ' off from actual value was: ' + diff[off].to_s
    end
  end

end

# runs for each pair (1-5) of base and test files
controller = Control.new
(1..5).each do |x|
  puts "\nFiles version " + x.to_s + ':'
  controller.run("ml-100k/u" + x.to_s)
end
