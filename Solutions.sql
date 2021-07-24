USE sakila;
-- 1. List each pair of actors that have worked together.
SELECT f.title, concat(a1.first_name, ' ', a1.last_name) AS actor1, concat(a2.first_name, ' ', a2.last_name) AS actor2
FROM actor a1
INNER JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
INNER JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id) AND (fa1.actor_id <> fa2.actor_id)
INNER JOIN actor a2 ON a2.actor_id = fa2.actor_id
JOIN film f ON fa1.film_id = f.film_id
;

-- 2. For each film, list actor that has acted in more films.
SELECT * FROM (
WITH cte_films_by_actor AS (
	SELECT actor_id, count(*) AS films_by_actor
	FROM film_actor
	GROUP BY actor_id
)
SELECT fa1.film_id, fa1.actor_id, cte.films_by_actor
	, RANK() OVER(PARTITION BY fa1.film_id ORDER BY cte.films_by_actor DESC) AS actor_rank
FROM film_actor fa1
JOIN cte_films_by_actor cte ON fa1.actor_id = cte.actor_id
ORDER BY fa1.film_id) base
WHERE actor_rank = 1
;

-- Trying to put the names
SELECT * FROM (
WITH cte_films_by_actor AS (
	SELECT actor_id, count(*) AS films_by_actor
	FROM film_actor
	GROUP BY actor_id
)
SELECT f.title, concat(a.first_name, ' ', a.last_name) AS actor_name, cte.films_by_actor
	, RANK() OVER(PARTITION BY fa1.film_id ORDER BY cte.films_by_actor DESC) AS actor_rank
FROM film_actor fa1
JOIN film f ON fa1.film_id = f.film_id
JOIN actor a ON fa1.actor_id = a.actor_id
JOIN cte_films_by_actor cte ON fa1.actor_id = cte.actor_id
ORDER BY fa1.film_id) base
WHERE actor_rank = 1
;