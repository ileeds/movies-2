require_relative 'ratings.rb'
require_relative 'validator.rb'

# instantiates and invokes ratings and validator classes
class Control

  def run(filename, version)
    ratings_base = Ratings.initialize_base(filename)
    ratings_test = Ratings.initialize_test(filename)
    diff, average, stdev = Validator.validate(ratings_base, ratings_test)
    show_stats(version, diff, average, stdev)
  end

  def show_stats(version, diff, average, stdev)
    puts "\nFiles version " + version + ':'
    puts 'Average error is: ' + average.to_s
    puts 'Standard deviation of the error is: ' + stdev.to_s
    (0..4).each do |off|
      puts 'Number of predictions ' + off.to_s + ' off from actual value was: ' + diff[off].to_s
    end
  end

end

controller = Control.new
(1..5).each do |x|
  controller.run("ml-100k/u" + x.to_s, x.to_s)
end
