USE sakila;
-- 1. List each pair of actors that have worked together.
WITH cte AS (
SELECT *
		FROM (
			SELECT fa1.film_id, concat(a1.first_name, ' ', a1.last_name) AS fan1, concat(a2.first_name, ' ', a2.last_name)  AS fan2
			FROM sakila.actor a1
			JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
			JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id) AND (fa1.actor_id != fa2.actor_id)
			JOIN actor a2 ON a2.actor_id = fa2.actor_id
        ) AS sub )
SELECT *
FROM cte;

-- 2. For each film, list actor that has acted in more films.
SELECT MAX(CONCAT(t.first_name, ' ', t.last_name))
FROM (	SELECT a.first_name, a.last_name, COUNT(*) OVER(PARTITION BY fa.actor_id ORDER BY COUNT(fa.actor_id))
		FROM actor a
        JOIN film_actor fa ON a.actor_id = fa.actor_id
        JOIN film f ON fa.film_id = f.film_id
        GROUP BY a.first_name, a.last_name, fa.actor_id) AS t;
