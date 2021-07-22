USE sakila;

-- 1. List each pair of actors that have worked together.
SELECT a.actor_id, b.actor_id
FROM film_actor a, film_actor b
where a.film_id = b.film_id
and a.actor_id <> b.actor_id;

-- 2. For each film, list actor that has acted in more films.
select * from (select film_id, actor_id, rank () over (partition by film_id order by actor_id desc) as ranking 
from film_actor
group by film_id, actor_id) t1 
where ranking = 1;