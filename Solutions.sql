-- lab-sql-advanced-queries
USE sakila;
-- List each pair of actors that have worked together.

WITH cte AS (
	SELECT r1.actor_id AS actor_a, r2.actor_id AS actor_b,
	count(r1.film_id) AS casted_together
	FROM film_actor r1 INNER JOIN film_actor r2 ON r1.film_id = r2.film_id
	AND r1.actor_id > r2.actor_id
	GROUP BY r1.actor_id, r2.actor_id
)
SELECT * FROM CTE
ORDER BY casted_together DESC;

    
-- For each film, list actor that has acted in more films.

WITH CTE1 AS (
	SELECT count(film_actor.actor_id) AS num_of_flms, actor.first_name, actor.last_name 
	FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY film_actor.actor_id
	ORDER BY COUNT(*) desc
)
SELECT * FROM CTE1;


