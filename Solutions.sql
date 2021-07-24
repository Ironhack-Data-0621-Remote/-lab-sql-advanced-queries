use sakila;
-- 1. List each pair of actors that have worked together.
-- I dont know if I get the question...
select * from film_actor; 

select f.film_id, f.actor_id, concat(a.first_name, ' ', a.last_name) as actor
from film_actor f
join actor a
on a.actor_id = f.actor_id
order by film_id;  -- shows all actor_ids which work on the same film set, but that are not all pairs 

-- 2. For each film, list actor that has acted in more than 1 films.