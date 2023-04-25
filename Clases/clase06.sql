-- Active: 1653564627884@@127.0.0.1@3306@sakila
SELECT last_name, first_name
FROM actor a
WHERE EXISTS(
    SELECT 1
    FROM actor b
    WHERE a.last_name = b.last_name
    AND a.actor_id <> b.actor_id
);

SELECT last_name
FROM actor A
WHERE EXISTS(
    SELECT 1
    FROM film_actor FA
    WHERE FA.film_id = NULL

);

select c.first_name, c.last_name
from customer as c
where(
    select count(*)
    from rental as r
    where c.customer_id=r.customer_id)=1;

    SELECT c.first_name, c.last_name FROM customer c
WHERE (SELECT count(*) FROM rental r WHERE c.customer_id = r.customer_id)>1;

select first_name, last_name
from actor as a
where a.actor_id in(select fa.actor_id from film_actor as fa where fa.film_id in (select f.film_id from film as f where f.title in ('BETRAYED REAR','CATCH AMISTAD')));

select first_name, last_name
from actor as a
where a.actor_id in(select fa.actor_id from film_actor as fa where fa.film_id in (select f.film_id from film as f where f.title='BETRAYED REAR' AND f.title!= 'CATCH AMISTAD'));

select a.first_name, a.last_name 
from actor a
where EXISTS (
  select * from film f join film_actor fa ON f.film_id = fa.film_id 
  where fa.actor_id = a.actor_id and f.title = 'BETRAYED REAR')
  and exists (
    select * from film f join film_actor fa ON f.film_id = fa.film_id where fa.actor_id = a.actor_id and f.title = 'CATCH AMISTAD');
select a.first_name, a.last_name
from actor  a
where not exists (
  select *
  from film as f 
  join film_actor fa ON f.film_id = fa.film_id where fa.actor_id = a.actor_id and (f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD')
);