USE sakila;
-- 1. List each pair of actors that have worked together.
select a.actor_id, a.film_id, b.actor_id
from film_actor a, film_actor b
where a.actor_id <> b.actor_id
and a.film_id = b.film_id;

-- 2. For each film, list actor that has acted in more films.
select film_id, t.actor_id
from (Select actor_id, count(film_id)
from film_actor
group by actor_id
having count(film_id) > 1
order by count(film_id)) t
join film_actor fa
on t.actor_id=fa.actor_id


