USE sakila;
-- 1. List each pair of actors that have worked together.
SELECT a.actor_id, b.actor_id
FROM film_actor a, film_actor b
WHERE a.film_id = b.film_id
AND a.actor_id <> b.actor_id;

-- 2. For each film, list actor that has acted in more films.

WITH cte AS (
	SELECT film_id,CONCAT(a1.first_name, ' ', a1.last_name) AS actor, COUNT(film_id) AS num_films
	FROM actor a1
    JOIN film_actor fa
    ON a1.actor_id = fa.actor_id
    GROUP BY film_id, actor)
SELECT f.title AS film, c.actor, c.num_films 
FROM cte c
JOIN film f 
ON f.film_id = c.film_id;