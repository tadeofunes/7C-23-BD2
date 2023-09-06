--creamos el usuario y ponemos la contrasenia segun pida los requisitos de nuestro sql
CREATE USER data_analyst IDENTIFIED BY 'password';
--comprobamos los usuarios
SELECT User, Host, plugin FROM mysql.user;  


--Le otorgamos los permisos a nuestro root
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';

SHOW GRANTS FOR 'data_analyst'@'%'; # ver los permisos que le dimos
--Aqui intentamos crear en la temrinal una tabla con el sig comando
--mysql -u data_analyst -p
use sakila;
CREATE TABLE Prueba(
	film_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(30) NOT NULL,
	description VARCHAR(30),
	release_year YEAR NOT NULL,
	PRIMARY KEY (film_id);
--ERROR 1142, no nos permite crear la tabla;


-- a continuacion cambiamos el titulo de la film id 5 a micky mouse
UPDATE film SET title = 'Micky mouse' WHERE film_id = 5;


mysql -u root -p
USE sakila;
SHOW GRANTS FOR 'data_analyst'@'localhost';
REVOKE UPDATE ON sakila.* from data_analyst;
SHOW GRANTS FOR 'data_analyst'@'localhost';


mysql -u data_analyst -p
USE sakila;
UPDATE film SET title = 'Micky mouse' WHERE film_id = 5;

-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'


