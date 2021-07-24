USE sakila;
-- 1. List each pair of actors that have worked together.
SELECT f.film_id, f.actor_id, a.first_name, a.last_name, f2.actor_id, a2.first_name, a2.last_name
FROM film_actor f
JOIN film_actor f2
ON f.actor_id <> f2.actor_id
AND f.film_id = f2.film_id
JOIN actor a 
ON f.actor_id = a.actor_id
JOIN actor a2
ON f2.actor_id = a2.actor_id;
-- i missed the class yesterday so i am not sure if we had to do this in a different way than in the earlier lab
-- should i re-try with cte? or views? or correlated subqueries?

-- 2. For each film, list actor that has acted in more films.
-- INTERPRETATION #1
-- query for actors appearing in more than 1 movie --->
WITH cte_multiple_movies AS (SELECT actor_id, COUNT(actor_id)
FROM film_actor
GROUP BY actor_id
HAVING COUNT(actor_id) > 1)
-- joins query --->
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id
RIGHT JOIN cte_multiple_movies mm
ON a.actor_id = mm.actor_id
ORDER BY f.title;

-- For each film, list actor that has acted in MOST films.
-- INTERPRETATION #2
-- was trying thousands of different queries but got entirely lost in tunnelvision thinking; 
-- hence the following is not the right answer, just an attempt.
-- how do i do this?
WITH cte_1 AS (
SELECT film_id, COUNT(actor_id) AS counted
FROM film_actor
GROUP BY film_id
HAVING counted = MAX(counted)
)
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name, cte_1.counted 
FROM cte_1
JOIN film f
ON cte_1.film_id = f.film_id
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
ORDER BY f.film_id;

-- checking queries --->
SELECT actor_id, COUNT(actor_id)
FROM film_actor
GROUP BY actor_id
HAVING COUNT(actor_id) > 1;    
