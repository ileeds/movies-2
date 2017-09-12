Movies Part 1


Description of solution:

The MovieData class reads in the entered file (u.data). It generates a hash, where
the key is the user id, and the value is another hash. This hash has a key of the
movie id, and a value of the rating the user gave this movie. This enables user ids
to be searched quickly, with all information of their movie preferences available.
The constructor also generates another hash, where the key is the movie id, and the
value is that movie's average rating. It does this by keeping track of all of its
ratings in an array, and then calculating the average. Finally, this hash is sorted
by most to least popular movie.

The popularity method simply looks up a movie id in the movie hash, and returns its
value (which is its average popularity).

The popularity_list method simply returns the keys of the movie hash, as it has
already been sorted (so the return value will be the movies in order of popularity).

The similarity method keeps track of how many movies two users have both rated, and
how similarly they have rated these movies. The more similarly the users rated their
movies, the larger the returned value. The fewer uncommon movies the users had,
aka the number of users one rated that the other did not relative to the total number
of movies they rated, the larger the returned value as well.

The most_similar method calls the similarity method for the user id entered against
every other user in the users hash. Since the similarity method in commutative,
the similarity method only needs to be called once per user pair.


Description of an algorithm to predict the ranking that a user U would give to a movie M assuming the user hasn’t already ranked the movie in the dataset:

This algorithm could examine the x most similar users to user U, and whichever of
these users gave a ranking for movie M, predict that user U would give a similar
rating. (For example, the algorithm could take the average rating of movie M from
the top 10 most similar users to user U).


Do the algorithms scale? What factors determine the execution time of the “most_similar” and “popularity_list” algorithms:

The most_similar algorithm runs in O(n) time, where n is the number of users. For
every user added, this algorithm will need to iterate an additional time, comparing
that additional user's rating to the user in question. However, if this MovieData
program were to 'go live,' it could store the most similar users to each user in
another hash (or database), and whenever a user is added, it could simply run the
similarity method against that user and the already existing users to update the
most similar lists, in which case the algorithm would scale well.

The popularity_list algorithm runs in constant time, as it simply takes the keys
of an already sorted hash, so this algorithm would certainly scale well.
