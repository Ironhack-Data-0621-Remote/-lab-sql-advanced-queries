USE sakila;


-- 1. List each pair of actors that have worked together.


with cte_actor1 as (
select actor_id as actor_id1, film_id
from film_actor),
cte_actor2 as (
select actor_id as actor_id2 , film_id
from film_actor)
select actor_id1, actor_id2
from cte_actor1
join cte_actor2
on cte_actor1.film_id  = cte_actor2.film_id
and cte_actor1.actor_id1 != cte_actor2.actor_id2;

-- this way gets us all the pairs of actors but just with their actor_ids

with cte_actor1 as (
select actor_id as actor_id1, film_id
from film_actor),
cte_actor2 as (
select actor_id as actor_id2 , film_id
from film_actor),
cte_name1 as (
select concat(first_name, ' ',last_name) as nam1, actor_id as actor_id3
from actor),
cte_name2 as (
select concat(first_name, ' ',last_name) as nam2, actor_id as actor_id4
from actor)
select nam1, nam2
from cte_actor1
join cte_actor2
on cte_actor1.film_id  = cte_actor2.film_id
and cte_actor1.actor_id1 != cte_actor2.actor_id2
join cte_name1
on cte_actor1.actor_id1 = cte_name1.actor_id3
join cte_name2
on cte_actor2.actor_id2 = cte_name2.actor_id4;
 
-- this way we have the names too. But could i make this query more efficient?


-- 2. For each film, list actor that has acted in more films.



with cte_films as (
select count(film_id) as film_count, actor_id
from film_actor
group by actor_id)
select fi.title, f.actor_id, cte_films.film_count
from film_actor f
join cte_films
on f.actor_id = cte_films.actor_id
join film fi
on fi.film_id = f.film_id
order by fi.title asc, film_count desc;

-- this gives us a list of the films with starring actor's ids and a count of how many films they have starred in

with cte_films as (
select count(film_id) as film_count, actor_id
from film_actor
group by actor_id),
cte_name as (
select concat(first_name, ' ',last_name) as nam1, actor_id as actor_id1
from actor)
select fi.title, cte_name.nam1, cte_films.film_count
from film_actor f
join cte_films
on f.actor_id = cte_films.actor_id
join film fi
on fi.film_id = f.film_id
join cte_name
on cte_name.actor_id1 = cte_films.actor_id
order by fi.title asc, film_count desc;

-- this gives us the same as above but the with actor's names instead of ids

