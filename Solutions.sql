USE sakila;
-- 1. List each pair of actors that have worked together.
select a.actor_id, b.actor_id, a.film_id 
from film_actor a
join film_actor b
on a.film_id = b.film_id
where a.actor_id <> b.actor_id;
-- the problem in my query is that I am showing each pair two times. Ex: a.actor_id 1, b.actor_id 10 ;; a.actor_id 10, b.actor_id 1

-- 2. For each film, list actor that has acted in more films.
select actor_id, film_id
from film_actor;

select actor_id, count(actor_id)
from film_actor
group by actor_id;

select *
from(
select f.film_id, f.actor_id, c.appearances, rank() over(partition by f.film_id order by c.appearances desc) as ranking
from film_actor f
join (select actor_id, count(actor_id) as appearances
from film_actor
group by actor_id) c
on f.actor_id = c.actor_id) sub1
where sub1.ranking=1;
