use sakila;
-- 1. List each pair of actors that have worked together.

select * from film_actor; 

-- subquery:
select f.actor_id as actor1, fa.actor_id as actor2, f.film_id
from film_actor f, film_actor fa
where f.film_id = fa.film_id
and f.actor_id != fa.actor_id;

-- combined:
select actor1, concat(a.first_name, ' ', a.last_name) as actorname1, actor2, concat(ac.first_name, ' ', ac.last_name) as actorname2, film_id
from (select f.actor_id as actor1, fa.actor_id as actor2, f.film_id
from film_actor f, film_actor fa
where f.film_id = fa.film_id
and f.actor_id != fa.actor_id) x
join actor a
on a.actor_id = x.actor1 
join actor ac 
on ac.actor_id = x.actor2
group by actor1, actor2
order by film_id;


-- 2. For each film, list actor that has acted in more than 1 films.

select fi.title, x.actor, x.count_films 
from (select film_id, concat(a.first_name, ' ', a.last_name) as actor, count(f.actor_id) as count_films
	from film_actor f
    join actor a
    on a.actor_id = f.actor_id
    group by a.actor_id
	order by film_id) x
join film fi 
on fi.film_id = x.film_id
where count_films > 1;