require_relative 'ratings.rb'
require 'byebug'

class Validator

  def initialize(ratings_base, ratings_test)
    @base = ratings_base
    @test = ratings_test
  end

  def validate
    @base.users
    @test.users.each do |user|
      @test.predict(user)
    end

  end

end
