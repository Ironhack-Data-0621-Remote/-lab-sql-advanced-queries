-- 1. List each pair of actors that have worked together.

USE sakila;
SELECT * FROM film_actor LIMIT 10;

WITH cte1 AS (
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, fa1.film_id
FROM film_actor fa1, film_actor fa2
WHERE fa1.film_id = fa2.film_id
AND fa1.actor_id != fa2.actor_id
)
SELECT film_id, actor1, concat(a.first_name, ' ', a.last_name) AS name1, actor2, concat(b.first_name, ' ', b.last_name) AS name2
FROM cte1 c
JOIN actor a
ON a.actor_id = c.actor1 
JOIN actor b 
ON b.actor_id = c.actor2
GROUP BY actor1, actor2
ORDER BY film_id;


-- 2. For each film, list actor that has acted in more films.


WITH cte3 AS (
	SELECT film_id, concat(a.first_name, ' ', a.last_name) AS actor, count(fa.actor_id) AS num_of_films
	FROM actor a
    INNER JOIN film_actor fa
    ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
	ORDER BY film_id
)
SELECT f.title AS film, c.actor, c.num_of_films 
FROM cte3 c
JOIN film f 
ON f.film_id = c.film_id
WHERE num_of_films > 1;
