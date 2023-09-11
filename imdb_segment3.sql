-- Segment 3: Production Statistics and Genre Analysis
--	1.Retrieve the unique list of genres present in the dataset.
	select distinct(genre) from genre_imdb;

--	2.Identify the genre with the highest number of movies produced overall.
	select * from(select genre,count(movie_id) as total_movies,row_number() over(order by count(movie_id) desc) as ranks from genre_imdb
    group by genre) d
    where ranks=1 ;

--	3.Determine the count of movies that belong to only one genre.
	select count(*) from (select count(*) from genre_imdb
    group by movie_id
    having count(genre)=1) as r;
--  3289

--	4.Calculate the average duration of movies in each genre.
	select g.genre,avg(m.duration) from genre_imdb as g join movies_imdb as m
    on g.movie_id=m.id
    group by g.genre;

--	5.Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
	select s.genre,s.ranks from (select genre,rank() over(order by count(genre) desc) as ranks from genre_imdb 
    group by genre) as s
    where genre='Thriller';