-- Active: 1653564627884@@127.0.0.1@3306@sakila
select c.country, c.country_id,  count(ci.city_id) as ciudades
from country c
inner join city  ci on c.country_id = ci.country_id
group by c.country_id, c.country
order by c.country_id, c.country;

select c.country,   count(ci.city_id) as ciudades
from country c
inner join city  ci on c.country_id = ci.country_id
group by  c.country
having count(ci.city_id) > 10
order by ciudades desc;

select concat(c.first_name, " ", c.last_name) as nombre, a.address, (select count(*) from rental r where c.customer_id = r.customer_id) as "Peliculas rentadas",
(select sum(p.amount) from payment p where c.customer_id = p.customer_id) as Dinerogastado
from customer c
join address a on c.address_id = a.address_id
group by c.first_name, c.last_name, a.address, c.customer_id
order by Dinerogastado desc;

select c.name , avg(f.length) as DuracionPromedio 
from film f join film_category fc on fc.film_id = f.film_id 
join category c on fc.category_id = c.category_id
group by c.name
order by DuracionPromedio DESC;

select f.rating, count(p.payment_id) as ventas
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id 
group by rating
order by ventas desc;

