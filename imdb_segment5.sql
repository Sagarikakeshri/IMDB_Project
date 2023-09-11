-- Segment 5: Crew Analysis
--	1.Identify the columns in the names table that have null values.
	  select sum(case when id is null then 1 else 0 end) as id_nulls,
sum(case when name is null then 1 else 0 end) as name_nulls,
sum(case when height is null then 1 else 0 end) as height_nulls,
sum(case when date_of_birth is null then 1 else 0 end) as date_of_birth_nulls,
sum(case when known_for_movies is null then 1 else 0 end) as known_for_movies_nulls
from names_imdb;
--	2.Determine the top three directors in the top three genres with movies having an average rating > 8.
	  with cte as (select genre from (select genre,rank() over(order by count(g.movie_id) desc) as ranks
      from genre_imdb g left join ratings_imdb r on g.movie_id=r.movie_id
      where avg_rating>8
      group by genre) a
      where ranks<=3),
      cte2 as (select name,genre,count(m.id) as total_movie,row_number() over(partition by genre order by count(m.id) desc) as director_rank
      from movies_imdb m
	  left join genre_imdb g on m.id=g.movie_id
	  left join director_mapping_imdb d on d.movie_id=m.id
	  left join names_imdb n on n.id=d.name_id
      where name is not null
      group by genre,name,n.id
      )
     select * from cte2 where genre in (select genre from cte) 
     and director_rank<=3
      
--	3.Find the top two actors whose movies have a median rating >= 8.
     select * from (select name,n.id,count(m.id) as movie_count,row_number() over(order by count(m.id) desc)as ranks from names_imdb n left join role_mapping_imdb r on
      (n.id=r.name_id)
      left join ratings_imdb ri on r.movie_id=ri.movie_id
      left join movies_imdb m on m.id=r.movie_id
      where category = 'actor' and median_rating>=8
      group by n.id,n.name) s
      where ranks<=2;
      
      
--	4.Identify the top three production houses based on the number of votes received by their movies.
	 with cte as (select production_company,sum(total_votes) as total_vote from movies_imdb m 
      left join ratings_imdb r on m.id=r.movie_id
      group by production_company
      order by total_vote desc),
	cte2 as (select *,row_number() over(order by total_vote desc)as ranks from cte)
      (select * from cte2 where ranks<=3);      
      
--	5.Rank actors based on their average ratings in Indian movies released in India.
	  select name,avg(avg_rating) as avg_ratings,row_number() over(order by avg(avg_rating) desc) as ranks 
      from movies_imdb m left join ratings_imdb r on m.id=r.movie_id
      left join role_mapping_imdb rm on r.movie_id=rm.movie_id
      left join names_imdb n on rm.name_id=n.id
      where category='actor' and country='India'
      group by n.id,n.name;
--	6.Identify the top five actresses in Hindi movies released in India based on their average ratings.
     select * from (select name,avg(avg_rating) as avg_ratings,row_number() over(order by avg(avg_rating) desc) as ranks from 
	  movies_imdb m left join ratings_imdb r on m.id=r.movie_id
	 left join role_mapping_imdb rm on m.id=rm.movie_id
	 left join names_imdb n on rm.name_id=n.id
	 where category='actress' and country='India' and languages='hindi'
     group by n.id,n.name) k
	 where ranks<=5;