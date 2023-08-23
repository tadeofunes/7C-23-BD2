-- Active: 1653564627884@@127.0.0.1@3306@sakila


insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1100,'Shicardo','Shamirez','x5940',null,'3',NULL,'ceo');
--El error nos indica que debemos colocar un mail


update employees set employeeNumber = employeeNumber - 20
-- Esta querry nos disminuye 20 empleados de su respectivo espacio en la tabla

update employees set employeeNumber = employeeNumber + 20
/* Este update nos tira un error ya que ya existe otro empleado con este numero por lo tanto no podra ser repetido */

alter table employees add column age int check(age >= 16 and age <= 70);

--ejercicio 4

/* Esta tabla es llamda una tabla intermedia para poder conectar dos tablas que por ejemplo compartan 2 foreign key entonces
se crea esta tabla   */


alter table employees add column lastUpdate datetime;

alter table employees add lastUpdateUser varchar(50);



DELIMITER $$
create trigger before_employees_update before update on employees for each row 
begin set NEW.lastUpdate = now();
SET NEW.lastUpdateUser = CURRENT_USER;
end$$
create trigger before_employees_insert before insert on employeesfor each row 
begin set NEW.lastUpdate = now(); 
SET NEW.lastUpdateUser = CURRENT_USER;
end$$
delimeter ;


SHOW TRIGGERS FROM sakila;

CREATE DEFINER=`user`@`%` TRIGGER `ins_film`  AFTER INSERT ON `film` FOR EACH ROW 
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
/* Una vez ingresado un valor el trigger inserta el id titulo y texto de film */

CREATE DEFINER=`user`@`%` TRIGGER `upd_film`
    AFTER UPDATE ON `film`
    FOR EACH ROW
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title, description=new.description, film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
/* Cuando hay una actualizacion en una pelicula este trigger actualiza su film text con los datos anteriormente mencionados */

CREATE DEFINER=`user`@`%` TRIGGER `del_film`
    AFTER DELETE ON `film`
    FOR EACH ROW
  BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
/* Esta simplemente borra el texto de una pelicula cuando es vieja y ya no se usa es decir que fue borrada */
