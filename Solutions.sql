USE sakila;

-- 1. List each pair of actors that have worked together.
-- I cannot think of a way to get around self join for this question
WITH cte_actor AS (
SELECT A.film_id, A.actor_id AS actor1, B.actor_id AS actor2
FROM film_actor A, film_actor B
WHERE A.film_id = B.film_id
AND A.actor_id != B.actor_id
)
SELECT actor1, actor2
FROM cte_actor
GROUP BY actor1, actor2
ORDER BY actor1;

-- 2. For each film, list actor that has acted in more films.
-- actors that have acted in more than one film
WITH cte_actor2 AS (
SELECT actor_id, count(film_id) as acted_in
FROM film_actor
GROUP BY actor_id
HAVING acted_in > 1
)
SELECT f.film_id, a.actor_id
FROM film_actor f
JOIN cte_actor2 a 
ON a.actor_id = f.actor_id
WHERE acted_in > 1
ORDER BY film_id;