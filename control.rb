require_relative 'ratings.rb'
require_relative 'validator.rb'

# instantiates and invokes ratings and validator classes
class Control

  def run(filename, version)
    ratings_base = Ratings.initialize_base(filename)
    ratings_test = Ratings.initialize_test(filename)
    stdev = Validator.validate(ratings_base, ratings_test)
    puts 'Standard deviation for files version ' + version + ' is: ' + stdev.to_s
  end

end

controller = Control.new
(1..5).each do |x|
  controller.run("ml-100k/u" + x.to_s, x.to_s)
end
