USE sakila;
-- 1. List each pair of actors that have worked together.
-- select CONCAT(a1.first_name, ' ', a1.last_name), CONCAT(a2.first_name, ' ', a2.last_name)
-- from film_actor fa1
-- inner join actor a1
-- on fa1.actor_id = a1.actor_id
-- inner join film_actor fa2
-- on (fa1.film_id = fa2.film_id) and (fa1.actor_id != fa2.actor_id)
-- inner join actor a2
-- on fa2.actor_id = a2.actor_id;


-- 2. For each film, list actor that has acted in more films.
select * from (
	select *, rank() over (partition by title order by film_id desc) as ranking from (
		select fa.film_id, f.title, CONCAT(a.first_name, ' ', a.last_name) as actor_name , count(*) as num_films
		from actor a
		inner join film_actor fa
		on a.actor_id = fa.actor_id
		inner join film f
		on fa.film_id = f.film_id
        having count(*) >3
	) sub1
    ) sub2;
-- where ranking = 1;