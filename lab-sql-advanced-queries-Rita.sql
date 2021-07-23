USE sakila;

-- 1. List each pair of actors that have worked together.

with cte1 as (
	SELECT actor_id, first_name, last_name
    FROM actor
    ),
    cte2 as (
    SELECT f.film_id, f.actor_id, c.first_name, c.last_name
    FROM film_actor f
    JOIN cte1 c
    ON f.actor_id = c.actor_id
    )
SELECT *
FROM cte2 c
JOIN cte2 c1
ON c.film_id = c1.film_id AND
c.actor_id != c1.actor_id;

-- I got 23830 rows
-- I don't understand why results are different than below query (1000 rows):

SELECT f.film_id, f.actor_id, a.first_name, a.last_name, f1.actor_id, a1.first_name, a1.last_name
FROM film_actor f
JOIN film_actor f1
ON f.film_id = f1.film_id AND
f.actor_id != f1.actor_id
JOIN actor a
ON a.actor_id = f.actor_id
JOIN actor a1
on a1.actor_id = f1.actor_id;

    
-- 2. For each film, list actor that has acted in more films

-- I dont think this is correct but could not solve it

with cte3 as (
	SELECT actor_id, rank () over(order by count(film_id) DESC) as rank1
    FROM film_actor
    GROUP BY actor_id
    ),
    cte4 as (
    SELECT *
    FROM cte3
    WHERE rank1 = 1
    ),
    cte5 as (
    SELECT f.actor_id, f.film_id, f1.title
    FROM film_actor f
    JOIN film f1
    ON f.film_id = f1.film_id
    )
    Select c1.title, c.actor_id, 
    FROM cte4 c
    JOIN cte5 c1
    ON c.actor_id = c1.actor_id
    GROUP BY c1.title, c.actor_id;

-- also did not work
SELECT film_id, actor_id, max(n_films)
FROM (SELECT f.film_id, t.actor_id, t.n_films
FROM film_actor f
JOIN (SELECT actor_id, count(*) as n_films
FROM film_actor
GROUP BY actor_id) t
ON f.actor_id = t.actor_id) as t
GROUP by film_id, actor_id;

