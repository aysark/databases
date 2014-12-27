/* Find the titles of all movies directed by Steven Spielberg.  */
select title from Movie M where M.director = 'Steven Spielberg';

/* Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.  */
select distinct year from Movie M natural join Rating R where R.stars = 4 or R.stars = 5 order by year asc;

/* Find the titles of all movies that have no ratings.  */
select title from Movie natural join (select mID from Movie except select mID from Rating);

/* Some reviewers didn't provide a date with their rating. Find the names of all reviewers who 
have ratings with a NULL value for the date. */
select name from Rating natural join Reviewer where ratingDate is null;

/* Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and 
ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.  */
select name, title, stars, ratingDate from (Reviewer natural join Movie) natural join Rating order by name, title, stars;

/* For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
return the reviewer's name and the title of the movie. */
select name, title from (Reviewer natural join (select count(mID),* from Rating R group by rID, mID having count(mID) > 1) 
	natural join Movie) where stars > 2

/* For each movie that has at least one rating, find the highest number of stars that movie received.
 Return the movie title and number of stars. Sort by movie title. */
select title, m from Movie natural join (select *, max(stars) as m from Rating group by mID) order by title;

/* For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest 
ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. */
select title, rating_spread from Movie natural join (select *, max-min as rating_spread from (select mID, max(stars) as max 
	from Rating group by mID) natural join (select mID, min(stars) as min from Rating group by mID)) order by rating_spread desc, title;

/* Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980.
 (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after.
  Don't just calculate the overall average rating before and after 1980.) */
select pre-post from (select avg(avg) as pre from Movie natural join (select *, avg(stars) as avg from Rating group by mID) 
	where year < 1980), (select avg(avg) as post from Movie natural join (select *, avg(stars) as avg from Rating group by mID)
	where year >= 1980);
