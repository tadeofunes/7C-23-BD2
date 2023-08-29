--Find all the film titles that are not in the inventory.



select f.title
from film as f
where not exists(select i.film_id from inventory as i where i.film_id = f.film_id);

--Find all the films that are in the inventory but were never rented.


select f.title, i2.inventory_id
from film as f
         join inventory i2 on f.film_id = i2.film_id
where exists(select i.film_id from inventory as i where i.film_id = f.film_id and not exists
(select r.inventory_id from rental as r where r.inventory_id = i.inventory_id));

--Generate a report with:


select c.first_name, c.last_name, s.store_id, f.title
from customer as c
join store s on c.store_id = s.store_id
join inventory i on s.store_id = i.store_id
join film f on i.film_id = f.film_id
where exists(select r.customer_id from rental as r where c.customer_id = r.customer_id and r.return_date is not null);

--Show sales per store (money of rented films)


SELECT s.store_id,
        CONCAT(ci.city, ', ', co.country) AS `City and Country`, 
        CONCAT(m.first_name, ' ', m.last_name) AS `First and Last Name`,
        (SELECT SUM(p.amount)
            FROM payment p
            WHERE p.staff_id = s.manager_staff_id) AS `Total money`
FROM staff m
JOIN store s ON m.staff_id = s.manager_staff_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci USING(city_id)
JOIN country co USING(country_id);

--Which actor has appeared in the most films?

select fa.actor_id, a.first_name, a.last_name, count(*) as totalfilm
from film_actor as fa
         inner join actor a on fa.actor_id = a.actor_id
group by fa.actor_id
order by totalfilm desc
LIMIT 1;