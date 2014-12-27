/* Find the names of all reviewers who rated Gone with the Wind.  */
select distinct name from Reviewer natural join Rating where mID = 101;

/* For any rating where the reviewer is the same as the director of the movie, 
return the reviewer name, movie title, and number of stars. */
select name, title, stars from (Reviewer natural join Rating) natural join Movie where name = director;

/* Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name 
of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) */
select name from Reviewer union select title from Movie order by name asc;

/* Find the titles of all movies not reviewed by Chris Jackson.  */
select distinct title from (select mID from rating except select mID from rating where rID = 205) natural join movie union 
select distinct title from movie m where m.mID not in (select mID from rating);

/* For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers.
 Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. 
 For each pair, return the names in the pair in alphabetical order.  */


 /* For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, 
 movie title, and number of stars. */
 select name, title, stars from rating r natural join reviewer re natural join movie m where stars = (select min(stars) from rating rt) 
 group by r.rID, r.mID;

 -- List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, 
 -- list them in alphabetical order. 
select title, avg(stars) as avg from rating natural join movie group by mID order by avg desc, title;

 -- Find the names of all reviewers who have contributed three or more ratings. 
select name from rating natural join reviewer group by rID having count(rID) > 2;

 -- Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, 
 -- along with the director name. Sort by director name, then movie title. 
select title, director from movie natural join (select director from movie group by director having count(director) > 1) 
order by director, title;

 -- Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
 -- (Hint: This query is more difficult to write in SQLite than other systems; you might think of it 
-- as finding the highest average rating and then choosing the movie(s) with that average rating.) 
select title, avg(stars) from rating natural join movie group by mID having avg(stars) = (select max(avg) as hi 
	from (select avg(stars) as avg from rating group by mID));

 -- Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
 -- (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it 
 	-- as finding the lowest average rating and then choosing the movie(s) with that average rating.) 
select title, avg(stars) from rating natural join movie group by mID having avg(stars) = (select min(avg) as hi 
	from (select avg(stars) as avg from rating group by mID));
