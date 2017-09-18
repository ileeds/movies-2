# will contain a sample of movie data from the data file
class Ratings

  attr_reader :users

  # called by other 2 initialize methods to instantiate class
  def initialize(users, movies)
    @users, @movies = users, movies
  end

  # instantiation for base file
  def self.initialize_base(filename)
    filename += ".base"
    @users = Hash.new
    @movies = Hash.new

    # read file to store user and movie data
    open(filename).read.each_line do |line|
      user_arr = line.split
      user_id, movie_id, movie_rating = split(user_arr)
      user = @users[user_id]
      if !user
          user = Hash.new
      end
      user[movie_id] = movie_rating

      if !user.key?(:average)
        user[:average] = Array.new
      end
      user[:average].push(movie_rating)
      @users[user_id] = user

      if !@movies.key?(movie_id)
          @movies[movie_id] = Array.new
      end
      @movies[movie_id].push(movie_rating)
    end

    # calculate user's average rating of all movies
    @users.each do |key, movies|
      @users[key][:average] = movies[:average].reduce(:+).to_f / movies.size
    end

    # calculate movie's average rating by all users
    @movies.each do |key, ratings|
      @movies[key] = ratings.reduce(:+).to_f / ratings.size
    end

    new(@users, @movies)
  end

  # instantiation for test file, does not need to keep track/calculate user and movie average statistics
  def self.initialize_test(filename)
    filename += ".test"
    @users = Hash.new
    @movies = Hash.new

    # read file to store user and movie data
    open(filename).read.each_line do |line|
      user_arr = line.split
      user_id, movie_id, movie_rating = split(user_arr)
      user = @users[user_id]
      if !user
          user = Hash.new
      end

      user[movie_id] = movie_rating
      @users[user_id] = user
    end
    new(@users, @movies)
  end

  # return an integer from 1 to 5 to indicate the popularity of a certain movie
  def popularity(movie_id)
    @movies[movie_id]
  end

  # generate a predictionvof what rating a user would give to a movie
  def predict(user, movie)
    popularity = popularity(movie)
    if popularity
      return (@users[user][:average] + popularity) / 2
    end
    3
  end

  # used to split rows of file into pieces of data
  def self.split(user_arr)
    return user_arr[0].to_i, user_arr[1].to_i, user_arr[2].to_i
  end

end
