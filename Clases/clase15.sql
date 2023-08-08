create a view list_of_customer as
select c.customer_id, CONCAT(c.first_name,' ', c.last_name) as full_name, a.`address`, a.postal_code as zip_code,
a.phone, ci.city, co.country, if(c.active, 'active', '') as `status`, c.store_id
from customer c join `address` a using(address_id) join city ci using(city_id) join country co using(country_id);
select * from list_of_customer;


create a view film_details as
SELECT f.film_id, f.title,f.description,c.name as category,f.rental_rate as price,f.length,f.rating,
group_concat(concat(a.first_name,' ',a.last_name)order by a.first_name SEPARATOR ', ') as actors
from film f join film_category fc using(film_id) join category c using(category_id) join film_actor fa using(film_id) join actor a using(actor_id)
group by f.film_id, c.name;
select * from film_details;
create a view sales_by_film_category as
select c.name as category, sum(p.amount) as total_sales
from payment p join rental using(rental_id) join inventory using(inventory_id) join film using(film_id) join film_category using(film_id) join category c using(category_id)
group by c.name
order by total_sales;
select * from sales_by_film_category;


create a view actor_information as
select a.actor_id as actor_id, a.first_name as first_name, a.last_name as last_name, COUNT(film_id) as films
from actor a join film_actor using(actor_id)
group BY a.actor_id, a.first_name, a.last_name;
select * from actor_information;

/*
 La query que esta dentro de la view actor info devuelve:
 El id de cada uno de los actores, el nombre de cada uno de los actores, el apellido de cada uno de los actores
 y una lista con todas las películas en las que este actua donde las mismas estan ordenadas alfabeticamente por categoria,
 ordenando alfabeticamente las categorías y dentro de cada una, organizando alfabeticamente las películas
 y una lista de las peliculas en las que actua con orden alfabetico por categoria y ordenando alfabeticamente las categorias ademas de ordenando alfabeticamente las peliculas

 */


 /* 
Las vistas materializadas son tablas creadas a partir de consultas a otras tablas, diseñadas para agilizar
 el acceso a datos frecuentemente utilizados. 
 Aunque pueden incrementar el tamaño de la base de datos y causar desfases, son útiles en situaciones 
 con grandes cantidades de datos o consultas repetitivas. Existen también vistas simples que se actualizan en tiempo real y 
 se utilizan en varios sistemas de gestión de bases de datos como PostgreSQL, MySQL, SQL Server, Oracle, Snowflake, Redshift y MongoDB. */
