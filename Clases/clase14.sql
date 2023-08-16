use sakila;

SELECT
    FIRST_NAME,
    LAST_NAME,
    a.address,
    c.city
FROM customer cu
    JOIN sakila.address a ON cu.address_id = a.address_id
    JOIN sakila.city c ON a.city_id = c.city_id
    JOIN sakila.country c2 ON c.country_id = c2.country_id
WHERE c2.country = 'ARGENTINA';

SELECT
    f.title,
    l.name AS language,
    f.rating,
    CASE
        WHEN f.rating = 'G' THEN 'All ages admitted'
        WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children'
        WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13'
        WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian'
        WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted'
    END AS 'Rating Text'
FROM film AS f
    INNER JOIN language AS l ON f.language_id = l.language_id;

SELECT
    CONCAT(
        ac.first_name,
        ' ',
        ac.last_name
    ) AS actor,
    f.title AS film,
    f.release_year AS release_year
FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor ac ON fa.actor_id = ac.actor_id
WHERE
    CONCAT(
        ac.first_name,
        ' ',
        ac.last_name
    ) LIKE CONCAT(
        '%',
        UPPER(TRIM('KIRSTEN AKROYD')),
        '%'
    );

SELECT
    f.title,
    r.rental_date,
    c.first_name AS customer_name,
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'Returned'
FROM rental r
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    INNER JOIN film f ON i.film_id = f.film_id
    INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE
    MONTH(r.rental_date) = 5
    OR MONTH(r.rental_date) = 6
ORDER BY r.rental_date;

/*  
 #5 Conversión de Tipos de Datos y Conjuntos de Caracteres
 Cuando trabajas con bases de datos, a veces necesitas cambiar el tipo de datos de una columna o ajustar el juego de caracteres en los datos almacenados. 
 Aquí hay dos funciones comunes para realizar estas conversiones: CAST y CONVERT.
 Función CAST
 La función CAST se utiliza para cambiar el tipo de datos de un valor en una consulta. Esto es útil cuando deseas transformar un valor de un tipo a otro.
  Por ejemplo, supongamos que tienes una columna de duración en minutos y deseas mostrarla en horas. Puedes usar CAST para hacer la conversión.
 */

SELECT CAST(LENGTH AS NCHAR(3)) AS DURACION FROM FILM;

/* Función CONVERT también se usa para conversiones de tipos de datos, pero tiene una capacidad adicional: puede manejar conjuntos de caracteres. 
Esto significa que no solo puedes cambiar el tipo de datos, sino también ajustar cómo se representan los caracteres en una columna. Si necesitas 
cambiar tanto el tipo de datos como el juego de caracteres, CONVERT es útil. Por ejemplo, para mostrar una fecha en un formato específico, puedes usar
CONVERT junto con DATE_FORMAT */


SELECT payment_id,
       CONVERT(payment_date, CHAR) AS original_date,
       DATE_FORMAT(payment_date, '%W, %M %e %Y') AS custom_date_format
FROM payment;



/* 
NVL, ISNULL, IFNULL y COALESCE, permiten devolver un valor alternativo cuando una expresión es NULL en una consulta SQL.
Diferencias entre ellas:
Cada función se usa en diferentes sistemas de administración de bases de datos (DBMS). Por ejemplo, 
en MySQL, solo estan IFNULL y COALESCE, 
NVL e ISNULL no están disponibles.



 */

--ifNull:
SELECT address_id, address, IFNULL(address2, "No existe una direccion") AS direccion_alternativa
FROM address;

--coalesce:
SELECT FILM_ID, COALESCE(original_language_id, 'NO DATA') as 'ORIGINAL_LANGUAGE'
FROM FILM;