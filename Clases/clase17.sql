select a.address, a.postal_code, ci.city, co.country
from address AS a
join city AS ci ON a.city_id = ci.city_id
join country AS co ON ci.country_id = co.country_id
where a.postal_code IN ('35200', '17886', '83579');
--11ms

select a.address, a.postal_code, ci.city, co.country
from address AS a
join city AS ci ON a.city_id = ci.city_id
join country AS co ON ci.country_id = co.country_id
where a.postal_code NOT IN ('35200', '17886', '83579');
--7ms 

create index PostalCode ON address(postal_code);

drop index postalCode on address;

select first_name FROM actor;
select last_name FROM actor;
show index FROM actor;

/* Ambas querys se runean en el mismo tiempo la unica diferencia es que la del apellido ya tiene un index  */

select description						
from film
where description like '%Fast-Paced%';
--10ms
CREATE FULLTEXT INDEX film_description_idx ON film(description);
select description									
from film
where MATCH(description) AGAINST('%Fast-paced%');
--6ms

/* En este caso es notorio la diferencia de latencia uno es casi la mitad que el otro por lo tanto en una base de datos mas pesada esto serviria mucho mas.
Full text es una herramienta muy eficaz para cuando necesitamos trabajar con cuerpos de textos son muy grandes */