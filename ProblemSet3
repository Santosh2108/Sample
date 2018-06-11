Create table Movie(mID number primary key, title varchar2(30), year int, director varchar2(30)); 
Create table Reviewer(rID number primary key, name varchar2(30)); 
Create table Rating (rID number,mID number,stars int,ratingDate date,foreign key(rID) references Reviewer(rID),foreign key(mID) references Movie(mID)); 



insert into movie values(101,'Gone with the Wind',1939,'Victor Fleming');
insert into movie values(102,'Star Wars',1977,'George Lucas');
insert into movie values(103,'The Sound of Music',1965,'George Lucas');
insert into movie values(104,'E.T.',1982,'Robert Wise');
insert into movie values(105,'Titanic',1997,'James Cameron');
insert into movie values(106,'Snow White',1937,'');
insert into movie values(107,'Avatar',2009,'James Cameron');
insert into movie values(108,'Raiders of the Lost Ark',1981,'Steven Spielberg');




insert into reviewer values(201,'Sarah Martinez');
insert into reviewer values(202,'Daniel Lewis');
insert into reviewer values(203,'Brittany Harris');
insert into reviewer values(204,'Mike Anderson');
insert into reviewer values(205,'Chirs Jackson');
insert into reviewer values(206,'Elizabeth Thomas');
insert into reviewer values(207,'James Cameron');
insert into reviewer values(208,'Ashley White');




insert into rating values(201,101,2,to_date('2011-01-22','yyyy-mm-dd'));
insert into rating values(201,101,4,to_date('2011-01-27','yyyy-mm-dd'));
insert into rating values(202,106,4,'');
insert into rating values(203,103,2,to_date('2011-01-20','yyyy-mm-dd'));
insert into rating values(203,108,4,to_date('2011-01-12','yyyy-mm-dd'));
insert into rating values(203,108,2,to_date('2011-01-30','yyyy-mm-dd'));
insert into rating values(204,101,3,to_date('2011-01-09','yyyy-mm-dd'));
insert into rating values(205,103,3,to_date('2011-01-27','yyyy-mm-dd'));
insert into rating values(205,104,2,to_date('2011-01-22','yyyy-mm-dd'));
insert into rating values(205,108,4,'');
insert into rating values(206,107,3,to_date('2011-01-15','yyyy-mm-dd'));
insert into rating values(206,106,5,to_date('2011-01-19','yyyy-mm-dd'));
insert into rating values(207,107,5,to_date('2011-01-20','yyyy-mm-dd'));
insert into rating values(208,104,3,to_date('2011-01-02','yyyy-mm-dd'));


/* 1.Find the titles of all movies directed by Steven Spielberg. */
				
select title from Movie where director='Steven Spielberg'



/* 2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. */
				
select distinct year from Movie m, Rating r 
where r.mID = m.mID and stars >= 4 
order by year;



/* 3.Find the titles of all movies that have no ratings.  */
				
select title from Movie where mID not in (select mID from Rating)



/* 4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. */ 

select distinct name from Reviewer r, Rating r1 
where r.rID = r1.rID and ratingDate is NULL;



/* 5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. */ 

select name, title, stars, ratingDate from Movie m, Rating r, Reviewer r1 
where m.mID = r.mID and r1.rID = r.rID order by name, title, stars;




/* 6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. */ 

select name, title from Movie, Reviewer, 
(select R1.rID, R1.mID from Rating R1, Rating R2 
where R1.rID = R2.rID and R1.mID = R2.mID and R1.stars < R2.stars and R1.ratingDate < R2.ratingDate) C 
where Movie.mID = C.mID and Reviewer.rID = C.rID;



/* 7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. */

select title,stars from movie m, rating r where m.mid=r.mid group by r.mid having max(stars);


/* 8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. */ 

select m.title,a.ratingspread from movie m join(select mid,max(stars)-min(stars) as ratingspread from rating group by mid) a  
on a.mid=m.mid order by a.ratingspread desc,m.title ; 



/* 9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)  */

select average1-average2 as diff_bw_beforeandafter80 from (select avg(avgbefore80) as average1 
from (select mid,avg(stars)as avgbefore80 from rating 
where mid in (select mid from movie where year<1980)  group by mid) a) c 
join (select avg(avgafter80) as average2 from (select mid,avg(stars)as avgafter80 from rating 
where mid in (select mid from movie where year>1980)  group by mid) b) d 
 


/* 10.Find the names of all reviewers who rated Gone with the Wind. */ 

select distinct name from Reviewer, Movie, Rating 
where Reviewer.rID = Rating.rID  and Rating.mID = Movie.mID and title = 'Gone with the Wind';



/* 11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. */ 

select distinct name, title, stars from Reviewer, Movie, Rating 
where Reviewer.rID = Rating.rID  and Rating.mID = Movie.mID and name = director; 
    			


/* 12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)  */

select name from (select name from Reviewer union select title as name from Movie ) as Name 
order by name ; 



/* 13.Find the titles of all movies not reviewed by Chris Jackson.  */

select distinct title from Movie except select distinct title from Reviewer, Movie, Rating 
where Reviewer.rID = Rating.rID  and Rating.mID = Movie.mID and name = 'Chris Jackson'; 



/* 14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.  */

select a.title,r.name from reviewer r join (select m.title,n.rid from movie m join  
(select mid,rid from rating group by mid,rid) n where m.mid=n.mid) a where r.rid=a.rid order by a.title,r.name; 



/* 15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.  */

select name, title, stars from Reviewer, Movie, Rating 
where stars is ( select min(stars) from Rating) and Reviewer.rID = Rating.rID  ; 



/* 16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.  */
 
select title, stars from Movie, ( select mID, avg(stars) as stars from Rating group by mID ) AvgRating 
where Movie.mID = AvgRating.mID 
order by stars DESC, title; 



/* 17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)  */

select name from Reviewer, ( select rID, count(stars) as count from Rating group by rID ) RateCount 
where Reviewer.rID = RateCount.rID and RateCount.count >= 3; 



/* 18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)  */

select M1.title, M1.director from Movie M1, Movie M2 where M1.director = M2.director and M1.title <> M2.title 
order by M1.director, M1.title ; 



/* 19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)  */

select m.title ,q.avg from movie m join 
(select mid,avg(stars) as avg from rating group by mid having avg(stars)= 
(select max(average) from(select mid,avg(stars) as average from rating group by mid) a)) q  
where m.mid=q.mid; 



/* 20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)  */

select m.title,s.avg from movie m join 
(select mid,avg(stars) as avg from rating group by mid having avg(stars)= 
(select min(average)from (select mid,avg(stars) as average from rating group by mid) p))  
s where m.mid=s.mid; 



/* 21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. */

select title, max(stars) as max_star, director from Movie, Rating 
where Movie.mID = Rating.mID and director is not NULL 
group by director; 

