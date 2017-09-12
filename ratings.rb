# will contain a sample of movie data from the data file
class Ratings

  attr_reader :users

  # the constructor of the MovieData class accepts a single parameter, the file
  # name of the main data file. It reads the file content in
  def initialize(filename)
    @users = Hash.new
    @movies = Hash.new

    open(filename).read.each_line do |line|
      if !@users.key?(line.split[0].to_i)
          @users[line.split[0].to_i] = Hash.new
      end
      # each user id key will have a value that is a hash
      # each key of this hash is the movie id, and each value is the movie's rating
      @users[line.split[0].to_i][line.split[1].to_i] = line.split[2].to_i

      if !@movies.key?(line.split[1].to_i)
          @movies[line.split[1].to_i] = Array.new
      end
      # each movie id key will have a value that is an array containg all user ratings
      @movies[line.split[1].to_i].push(line.split[2].to_i)
    end

    # calculate the average rating of each movie
    @movies.each do |key, value|
      @movies[key] = value.reduce(:+).to_f / value.size
    end

    #sort the movies hash by most to least popular
    @movies = @movies.sort_by {|key, value| value}.reverse.to_h
  end

  # return an integer from 1 to 5 to indicate the popularity of a certain movie
  def popularity(movie_id)
    @movies[movie_id]
  end

  # generate a list of all movie_id’s ordered by decreasing popularity
  def popularity_list
    @movies.keys
  end

  # generate a number between 0 and 1 indicating the similarity in movie
  # preferences between user1 and user2. 0 is no similarity
  def similarity(user1, user2)
    common_movies=0
    similar_tastes = Array.new
    @users[user1].each do |key, value|
      # keep track of common movies and difference of ratings of these movies
      if @users[user2].key?(key)
        common_movies+=1
        similar_tastes.push(4-((value-@users[user2][key]).abs))
      end
    end
    taste_num = (similar_tastes.reduce(:+).to_f / similar_tastes.size) / 4
    uncommon_movies = Math.sqrt(@users[user1].size + @users[user2].size) - common_movies
    #similarity based on similarity of ratings/movies in common
    taste_num / uncommon_movies+1
  end

  # return a list of users whose tastes are most similar to the tastes of user u
  def most_similar(u)
    similar_users = Hash.new
    # similarity between user and all other users
    @users.each do |key, value|
      if key != u
        similar_users[key] = similarity(u, key)
      end
    end
    similar_users.sort_by {|key, value| value}.reverse.to_h.keys
  end

  def predict(user, movie)
    4
  end

end
