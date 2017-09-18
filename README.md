Movies Part 2


Algorithm:

The algorithm to predict what a user would rate a movie takes the average of two values from the base data: The average rating the user rated all movies, and the average that movie was rated by all movies. An advantage of this algorithm is its speed. The values required have already been calculated in the instantiation of the Ratings class, so each call to the predict method runs in constant time. Of course, this means that the instantiation of the class takes longer (although this is done once, where the predict method may be called thousands of times). A disadvantage is that it does not use any information about the user other than the user's average rating of movies - it does not look into any of the other available information about users. However, this results in a faster prediction algorithm, and experimentation with additional user information did not yield significantly improved results.

Analysis:

My prediction method's results were compared to the results of returning the value '3' for the predict method across all base and test files. (3 was selected, as it was found to be the constant with the most accurate results). As can be seen in the running_transcript text, my prediction method was significantly more accurate, with an average error of approximately 0.623 less than that of the constant return value, and a standard deviation approximately 0.176 less. My algorithm also had far more correct guesses, and fewer predictions off by 1 or 2. It also did not have any guesses that were off by the maximum of 4. (It did have some more guesses that were off by 3 than the constant return value, but this is because the return value of 3 could not be off by 3 from another value.)

Benchmarking:

The overall runtime of this program, which includes analyzing and predicting five pairs of base and test files and displaying the statistical results, is between 1.0 and 1.1 seconds. Each run of the predict method is almost instantaneous, as the time it takes to run is at most approximately 2 * 10^-6 seconds. This time would not be affected were the application to scale. However, the time to instantiate the Ratings class would increase, although minimally. Each additional user's data will simply be read in and its average rating of movies will be calculated, and the movie ratings will contribute to that movie's average rating. The real concern would be memory usage, as this data is stored in memory rather than a database.

Other:

The reek gem and Code Climate have found no issues with this code.
