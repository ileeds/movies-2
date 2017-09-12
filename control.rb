require_relative 'ratings.rb'
require_relative 'validator.rb'

class Control

  def run(version)
    ratings_base = Ratings.new("ml-100k/u" + version.to_s + ".base")
    ratings_test = Ratings.new("ml-100k/u" + version.to_s + ".test")
    validator = Validator.new(ratings_base, ratings_test)
  end

end

controller = Control.new
controller.run(1)
