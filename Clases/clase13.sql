Use sakila;
/* 1. Add a new customer */
INSERT INTO
    customer (
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        active,
        create_date,
        last_update
    )
VALUES (
        1,
        'TADEO',
        'FUNES',
        'tade6funes@gmail.com', (
            SELECT MAX(A.address_id)
            FROM address AS A
                JOIN city AS CI ON A.city_id = CI.city_id
                JOIN country CO ON CI.country_id = CO.country_id
            WHERE
                CO.country = 'United States'
        ),
        1,
        CURRENT_TIME(),
        CURRENT_TIMESTAMP()
    );
/* 2. Add a rental */
INSERT INTO
    rental (
        inventory_id,
        rental_date,
        staff_id,
        customer_id,
        return_date
    )
VALUES (
        CURRENT_DATE(), (
            SELECT I.inventory_id
            FROM
                inventory AS I
                JOIN film AS F on I.film_id = F.film_id
            WHERE
                F.title = 'ACADEMY DINOSAUR'
            LIMIT
                1
        ), 1, CURRENT_DATE(), (
            SELECT MAX(staff_id)
            FROM
                staff
            WHERE
                store_id = 2
        )
    );
/* 3. Update film year based on the rating */
UPDATE film
SET
    release_year = CASE rating
        WHEN 'G' THEN '2001'
        WHEN 'PG' THEN '2004'
        ELSE release_year
    END;
/*4. Return a film */
SELECT F.film_id
FROM film as F
    JOIN inventory AS I on I.film_id = F.film_id
    JOIN rental AS R on I.inventory_id = R.inventory_id
WHERE
    R.return_date > CURRENT_DATE()
ORDER BY rental_date DESC
LIMIT 1;
/* 5. Try to delete a film */
DELETE FROM film WHERE film_id = 1;


/* 6. Rent a film */
INSERT INTO
    rental (
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id
    )
VALUES (
        CURRENT_DATE(), (
            SELECT I.inventory_id
            FROM
                inventory AS I
            WHERE
                NOT EXISTS(
                    SELECT * FROM rental AS R
                    WHERE R.inventory_id = I.inventory_id AND R.return_date < CURRENT_DATE()
                )
            LIMIT
                1
        ), 1, CURRENT_DATE(),
        1
    );

INSERT INTO
    payment (
        customer_id,
        staff_id,
        rental_id,
        amount,
        payment_date
    )
VALUES (
        1, 1, (
            SELECT
                LAST_INSERT_ID()
        ),
        10.2,
        CURRENT_DATE
    )