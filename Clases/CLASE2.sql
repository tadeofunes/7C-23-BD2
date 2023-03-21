-- Active: 1653564627884@@127.0.0.1@3306@imdb
drop DATABASE if exist imdb;
create table if not exist imdb
use imdb;
create table FILM(Film_id int primary key AUTO_INCREMENT, title varchar(20), description text, release_year date);
CREATE TABLE ACTOR(
ID INT PRIMARY KEY AUTO_INCREMENT,
FIRST_NAME VARCHAR(30),
LAST_NAME VARCHAR(30)

);

CREATE TABLE FILM_ACTOR(
    ID INT PRIMARY KEY AUTO_INCREMENT,FILM_ID INT 
    , ACTOR_ID INT 

);

ALTER TABLE ACTOR
    ADD LAST_UPDATE DATE;

ALTER TABLE FILM
    ADD LAST_UPDATE DATE;

ALTER TABLE FILM_ACTOR
ADD
CONSTRAINT FOREIGN KEY (FILM_ID) REFERENCES FILM (Film_id);  

ALTER TABLE FILM_ACTOR
ADD 
CONSTRAINT FOREIGN KEY (ACTOR_ID) REFERENCES ACTOR(ID);

INSERT INTO FILM (title, description, release_year)
VALUES ('Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', '2010-07-13');

INSERT INTO FILM (title, description, release_year)
VALUES ('The Matrix', 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', '1999-03-31');


INSERT INTO ACTOR (first_name, last_name)
VALUES ('Leonardo', 'DiCaprio');

INSERT INTO ACTOR (first_name, last_name)
VALUES ('Keanu', 'Reeves');


INSERT INTO FILM_ACTOR (film_id, actor_id)
VALUES (1, 1);

INSERT INTO FILM_ACTOR (film_id, actor_id)
VALUES (2, 2);






