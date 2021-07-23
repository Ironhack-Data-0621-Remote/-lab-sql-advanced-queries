USE sakila;
-- 1. List each pair of actors that have worked together.
SELECT * from actor;
SELECT * from film_actor;

-- first self join the tables
SELECT fc1.actor_id as actor1, fc2.actor_id as actor2 from
    film_actor fc1
    JOIN film_actor fc2
    ON fc1.film_id = fc2.film_id
    WHERE fc1.actor_id <> fc2.actor_id;

-- put the self join in to CTE
-- and then join with actor table to obtain the names
WITH actor_pairs as (
	SELECT fc1.actor_id as actor1, fc2.actor_id as actor2 
    from film_actor fc1
    JOIN film_actor fc2
    ON fc1.film_id = fc2.film_id
    WHERE fc1.actor_id <> fc2.actor_id
)
SELECT ap.actor1, ap.actor2, a.first_name, a.last_name
FROM actor_pairs ap
JOIN actor a
ON ap.actor1 = a.actor_id;

-- 2. For each film, list actor that has acted in more films.
select * from film; -- film_id, title
select * from film_actor; 

-- First check how many film each actor has acted
SELECT actor_id, count(film_id) as num_film -- , rank() over (partition by actor_id order by count(film_id)) as ranking
FROM film_actor
GROUP BY actor_id;

-- Then check which actor acted in per film
SELECT DISTINCT fc2.film_id, fc2.actor_id
FROM film_actor fc1
JOIN film_actor fc2
ON fc1.film_id = fc2.film_id;


-- Then 
WITH actor_film as (
	SELECT DISTINCT fc2.film_id, fc2.actor_id
	FROM film_actor fc1
	JOIN film_actor fc2
	ON fc1.film_id = fc2.film_id
    ),
num_act as (
	SELECT actor_id, count(film_id) as num_film 
	FROM film_actor
	GROUP BY actor_id
    ),
ranking as (
	SELECT * FROM
	(
	SELECT af.film_id, af.actor_id, na.num_film, dense_rank() over (partition by af.film_id order by na.num_film DESC) as ranking -- af.film_id, af.actor_id, na.num_film 
	FROM actor_film af
	JOIN num_act na
	ON af.actor_id = na.actor_id) t1
	WHERE ranking = 1)
SELECT r.film_id, r.actor_id, num_film, ranking, first_name, last_name


