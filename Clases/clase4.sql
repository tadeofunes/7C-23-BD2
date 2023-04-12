-- Active: 1653564627884@@127.0.0.1@3306@sakila
select f.title, f.special_features, f.rating
from film as f
where rating='PG-13';

select f.title, f.length
from film as f;

select f.title,f.rental_rate, f.replacement_cost 
from film as f
where f.replacement_cost BETWEEN 20.00 and 24.00;

select f.title,rating,special_features,c.name 
 from film f
inner join category c on category_id
where special_features ='Behind the scenes'
;

select a.first_name, a.last_name, f.title
from actor as a
inner join film f
where title="ZOOLANDER FICTION";

select a.address , c.city,cou.country,s.store_id
from address as a
inner join city c 
inner join country as cou
inner join store s 
where store_id=1;

SELECT  f1.title  , f2.title  ,f1.rating
FROM film f1 , film f2
WHERE f1.rating  =  f2.rating AND f1.film_id <> f2.film_id
;

select s.first_name,s.last_name,f.title,st.store_id
from staff s
inner join store st on s.staff_id=st.store_id
inner join inventory i on st.store_id=i.store_id
inner join film f on i.film_id=f.film_id
where st.store_id=2;