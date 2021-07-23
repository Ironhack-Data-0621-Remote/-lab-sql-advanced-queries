USE sakila;

-- 1. List each pair of actors that have worked together.
WITH cte_fa AS (
	SELECT fa1.film_id, fa1.actor_id AS actor1_id, fa2.actor_id AS actor2_id 
	FROM film_actor fa1
    JOIN film_actor fa2
    ON fa1.film_id = fa2.film_id
	AND fa1.actor_id <> fa2.actor_id
 )
SELECT film_id, actor1_id, concat(a1.first_name, ' ', a1.last_name) AS actor1, actor2_id, concat(a2.first_name, ' ', a2.last_name) AS actor2
FROM cte_fa fa
JOIN actor a1
ON fa.actor1_id = a1.actor_id 
JOIN actor a2 
ON fa.actor2_id = a2.actor_id
ORDER BY film_id;

-- 2. For each film, list actor that has acted in more films.
WITH cte_faa AS (
 	SELECT fa.actor_id,  concat(a.first_name, ' ', a.last_name) AS actor, COUNT(fa.film_id) AS film_count
 	FROM film_actor fa 
	JOIN actor a
	ON fa.actor_id = a.actor_id
	GROUP BY a.actor_id    
 )
SELECT  fa.film_id, f.title, faa.actor_id, faa.actor, faa.film_count
FROM cte_faa faa
JOIN film_actor fa
ON faa.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
WHERE film_count > 1;