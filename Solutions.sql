USE sakila;

-- 1. List each pair of actors that have worked together.
SELECT * FROM film_actor;

WITH cte1 AS
	(SELECT fa1.film_id, fa1.actor_id AS actor_1, fa2.actor_id AS actor_2
	FROM film_actor fa1
    JOIN film_actor fa2
	ON fa1.actor_id <> fa2.actor_id AND fa1.film_id = fa2.film_id),
		cte2 AS
			(SELECT f.title,
					CONCAT(a.first_name, ' ', a.last_name) AS actor_name_1, 
					CONCAT(a1.first_name, ' ', a1.last_name) AS actor_name_2
			FROM cte1 c
			JOIN actor a
			ON a.actor_id = c.actor_1 
			JOIN actor a1
			ON a1.actor_id = c.actor_2
			JOIN film f
			ON f.film_id = c.film_id)
SELECT *
FROM cte2;


-- 2. For each film, list all the actors that have acted in this + more films.

-- this query pretty much answers the question already:
-- it orders the table in a way that we see directly which actors acted in a film
SELECT film_id, actor_id, RANK() OVER(PARTITION BY film_id ORDER BY actor_id)
FROM film_actor; 

WITH cte1 AS -- the amount of films each actor has acted in
	(SELECT actor_id, COUNT(film_id) AS total_count_films 
	FROM film_actor
	GROUP BY actor_id),
		cte2 AS -- sorting list to show film + actors who have acted in it
			(SELECT film_id, fa.actor_id, total_count_films, RANK() OVER(PARTITION BY film_id ORDER BY actor_id)
			FROM film_actor fa
			JOIN cte1 c
			USING (actor_id)),
				cte3 AS -- joining other tables to be able to show film title and actor names (not a necessary step)
					(SELECT f.film_id, f.title, c2.actor_id, 
							CONCAT(a.first_name, ' ', a.last_name) AS name_actor, 
							total_count_films
					FROM cte2 c2
					JOIN film f
					USING (film_id)
					JOIN actor a
					USING (actor_id))
SELECT *
FROM cte3
WHERE total_count_films > 1; -- condition to only show actor if she/he has acted in other films as well (this however doesn't exclude anyone as everyone acted in more than one film)