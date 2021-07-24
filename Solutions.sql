USE sakila;
-- 1. List each pair of actors that have worked together.
with a1 as(
	select a.first_name, a.last_name, a.actor_id, fa.film_id
	from actor a
	join film_actor fa
	on a.actor_id = fa.actor_id
)
select a1.first_name, a1.last_name, a2.first_name, a2.first_name
from a1
join a1 as a2
on a1.first_name <> a2.first_name
and a1.film_id = a2.film_id;

-- 2. For each film, list actor that has acted in more films.
with actor_id_and_number_of_acted as (
	select actor_id, count(film_id) as acted
	from film_actor
	group by actor_id
),
actor_with_their_names as(
	select p.actor_id, p.acted, a.first_name, a.last_name
    from actor_id_and_number_of_acted p
    join actor a
    on p.actor_id = a.actor_id
),
actor_and_film_id as(
	select p.first_name, p.last_name, p.acted, a.film_id
    from actor_with_their_names p
    join film_actor a
    on p.actor_id = a.actor_id
),
actor_and_film_names as(
	select p.first_name, p.last_name, p.acted, p.film_id, f.title
    from actor_and_film_id p
    join film f
    on p.film_id = f.film_id
)
select title, first_name, last_name, acted
from actor_and_film_names
where acted > 1
order by film_id, acted desc;
