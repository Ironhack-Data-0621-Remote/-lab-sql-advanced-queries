USE sakila;
-- 1. List each pair of actors that have worked together.

-- with JOIN
SELECT t1.actor_id, t2.actor_id, t1.film_id
FROM film_actor AS t1
JOIN film_actor AS t2
WHERE t1.actor_id <> t2.actor_id
AND t1.film_id = t2.film_id
ORDER BY t1.film_id;

-- with CTE but I am not sure if this one works well because it gives a lot of rows...
WITH cte_actors AS(
SELECT actor_id, film_id
FROM film_actor), 
cte_acteurs AS(
SELECT actor_id
FROM cte_actors)
SELECT* FROM cte_actors
JOIN cte_acteurs 
ON cte_actors.actor_id <> cte_acteurs.actor_id
ORDER BY film_id;


-- 2. For each film, list actor that has acted in more films.
SELECT film_id, actor_id, COUNT(*) OVER(PARTITION BY film_id ORDER BY actor_id)
FROM film_actor; 

