-- Active: 1653564627884@@127.0.0.1@3306@sakila
select title, length, rating
from film 
where length <= ALL (select length  from film );


select title, length
from film f
where length <= ALL  (select length from film )
and not exists(select * from film as f2 where f2.film_id <> f.film_id and f2.length <= f.length);


select concat(c.first_name, " " ,c.last_name) as "Nombre ", a.address, min(p.amount)  as "Pago minimo"
from customer c
join address a on c.address_id = a.address_id
join payment  p on c.customer_id = p.customer_id
where p.amount = all (
  select MIN(amount)
  from payment
  where customer_id = c.customer_id)
group by c.first_name, c.last_name, a.address;


select concat(c.first_name," ",c.last_name) as "Nombre",  a.address, min(p.amount) as "Pago minimo", max(p.amount) as "Pago maximo"
from customer c
join address a on c.address_id = a.address_id
join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name, a.address;