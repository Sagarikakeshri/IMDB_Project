use movie_project;

-- Segment 1: Database - Tables, Columns, Relationships

-- 1.What are the different tables in the database and how are they connected to each other in the database?
--     There are 6 different tables in the database movie_project those are director_mapping_imdb,genre_imdb,movies_imdb,names_imdb,ratings_imdb,role_mapping_imdb.
--	  The tables are connected on movie_id and name_id with each other.
      
      
-- 2.Find the total number of rows in each table of the schema.
-- director_mapping_imdb table
      select count(*) from director_mapping_imdb;
--     3867 
-- genre_imdb table
	  select count(*) from genre_imdb;
--     14662
-- movies_imdb table
	  select count(*) from movies_imdb;
--     7997
-- names_imdb table
	  select count(*) from names_imdb;
--      25735
-- rating_imdb table
	  select count(*) from ratings_imdb;
--      7997
-- role_mapping_imdb table
	  select count(*) from role_mapping_imdb;
--      15615
      
      
--	3.Identify which columns in the movie table have null values.
	select sum(case when id is null then 1 else 0 end) as id_null,
    sum(case when title is null then 1 else 0 end) as title_null,
    sum(case when year is null then 1 else 0 end) as year_null,
    sum(case when date_published is null then 1 else 0 end) as date_null,
    sum(case when duration is null then 1 else 0 end) as duration_null,
    sum(case when country is null then 1 else 0 end) as country_null,
    sum(case when worlwide_gross_income is null then 1 else 0 end) as income_null,
    sum(case when languages is null then 1 else 0 end) as languages_null,
    sum(case when production_company is null then 1 else 0 end) as production_null from movies_imdb;
    
-- id_null=0  
-- title_null=0 
-- year_null=0 
-- date_null=0
-- duration_null=0
-- country_null=20
-- income_null=3724
-- languages_null=194
-- production_null=528