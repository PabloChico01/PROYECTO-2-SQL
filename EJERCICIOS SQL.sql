--Enunciado 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’
select "title", "rating"
from film
where "rating" = 'R';

--Enunciado 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select "actor_id", concat("first_name",' ',"last_name") as nombre_completo_actor
from "actor"
where "actor_id" between 30 and 40;

--Enunciado 4. Obtén las películas cuyo idioma coincide con el idioma original.
select "title" , "original_language_id","language_id"
from "film" 
where "language_id" ="original_language_id";

--Enunciado 5. Ordena las películas por duración de forma ascendente
select "title" , "length" as total_duracion
from film
order by "length" asc;

--Enunciado 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select "first_name" , "last_name"
from "actor" 
where "last_name" = 'ALLEN';

--Enunciado 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select "rating" ,count("film_id") as tota_peliculas
from "film"
group by "rating";

--Enunciado 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title" , "rating" , "length"
from film
where "rating" = 'PG-13'
or "length" >180
order by "length" ASC;

--Enunciado 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select  ROUND(VARIANCE("replacement_cost"),2) as varianza_coste_reemplazo
from "film";

--Enunciado 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MIN("length") as duracion_min_pelicula, MAX("length") as duracion_max_pelicula
from "film";

-- Enunciado 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select "rental_id" , "amount","payment_date"
from "payment"
order by "rental_id" desc , "payment_date"
limit 1 offset 2; 

--Enunciado 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select "title" , "rating"
from "film"
where "rating" not in ('NC-17','G');

--Enunciado 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select ROUND(AVG("length"),2) as media_duracion_peliculas , "rating" as clasificación_peliculas
from "film"
group by "rating";

--Enunciado 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title","length"
from "film"
where "length" >180
order by "length" ASC; 

--Enunciado 15. ¿Cuánto dinero ha generado en total la empresa?
select ROUND(SUM(amount),2) as total_generado
from "payment";

--Enunciado 16. Muestra los 10 clientes con mayor valor de id
select concat("first_name", ' ', "last_name") as nombre_completo , "customer_id"
from "customer"
order by "customer_id" desc
limit 10;

--Enunciado 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’
select Concat(a."first_name",' ',"last_name") as nombre_completo , f2."title"
from "actor" as a
inner join "film_actor" as f
on a."actor_id" = f. "actor_id"
inner join "film" as f2
on f."film_id"= f2."film_id"
where f2."title" = 'EGG IGBY';

-- Enunciado 18. Selecciona todos los nombres de las películas únicos
select "title", count(distinct("title")) as peliculas_unicas 
from "film"
group by "title";

-- Enunciado 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”
select f."title" , c."name" ,f."length"
from "film" as f
inner join "film_category" as f2
on f."film_id"= f2."film_id"
inner join "category" as c
on f2."category_id"=c."category_id"
where c."name" = 'Comedy'and f."length" >180;


--Enunciado 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name", ROUND(AVG (f."length"),2) as promedio_duracion
from "film" as f
inner join "film_category" as f2
on f."film_id"= f2."film_id"
inner join "category" as c
on f2."category_id"=c."category_id"
group by c. "name"
having ROUND(AVG("length"),2) > 110
order by promedio_duracion asc;


--Enunciado 21. ¿Cuál es la media de duración del alquiler de las películas?
select ROUND(AVG("rental_duration"),2) as media_duracion_peliculas__de_alquiler
from "film";

--Enunciado 22.Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat("first_name", ' ', "last_name") as nombre_completo_actores
from "actor";

--Enunciado 23.Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select "rental_date",COUNT("rental_id") as numero_alquiler
from "rental"
group by "rental_date"
order by numero_alquiler DESC;

--Enunciado 24. Encuentra las películas con una duración superior al promedio
select "title",ROUND(AVG("length"),2) as duración_promedio 
from "film"
where "length" > (select (ROUND(AVG("length"),2))from "film")
group by "title"
order by duración_promedio ASC ;

--Enunciado 25. Averigua el número de alquileres registrados por mes.
SELECT 
    EXTRACT(YEAR FROM "rental_date") AS año,
    EXTRACT(MONTH FROM "rental_date") AS mes,
    COUNT("rental_id") AS total_alquileres
FROM "rental"
GROUP BY año, mes
ORDER BY año, mes;

--Enunciado 26.Encuentra el promedio, la desviación estándar y varianza del total pagado.
select ROUND(AVG("amount"),2) as promedio_total_pagado,
ROUND(VARIANCE("amount"),2) as varianza_total_pagado,
ROUND(STDDEV("amount"),2) as desv_total_pagado
from "payment";

--Enunciado 27. ¿Qué películas se alquilan por encima del precio medio?
select "title", round(AVG("rental_rate"),2) as precio_medio
from "film"
where "rental_rate"> (select round(AVG("rental_rate"),2) from "film")
group by "title"
order by precio_medio asc;

--Enunciado 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select "actor_id", Count("film_id") as peliculas_total
from "film_actor"
group by "actor_id"
having count ("film_id") >40
order by "actor_id";

--Enunciado 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
select f. "title" ,count(i."inventory_id") as inventario_total
from "inventory" as i
left join "film" as f
on i."film_id" = f."film_id"
group by f."title"
order by "inventario_total";

--Enunciado 30. Obtener los actores y el número de películas en las que ha actuado.
select concat(a. "first_name",' ',"last_name") as nombre_actor, count(f."film_id") as total_peliculas_actuado
from "actor" as a
inner join "film_actor" as f
on a. "actor_id" = f. "actor_id"
group by a. "actor_id"
order by total_peliculas_actuado;

--Enunciado 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados
select f."title" , Count(f2."actor_id") as recuento_actores_actuado
from "film" as f
left join "film_actor" as f2
on f. "film_id" = f2. "film_id"
group by f."title"
order by recuento_actores_actuado;

--Enunciado 32.Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select Concat(a."first_name", ' ', "last_name") as nombre_completo ,Count(f."film_id") as recuento_peliculas_actuado
from "actor" as a 
left join "film_actor" as f
on a."actor_id" = f."actor_id"
group by Concat(a."first_name", ' ', "last_name")
order by recuento_peliculas_actuado; 

--Enunciado 33.. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f."title", r."rental_id", i."inventory_id"
from "rental" as r
inner join "inventory" as i 
on r."inventory_id" = i."inventory_id"
inner join "film" as f
on i."film_id"=f."film_id";

--Enunciado 34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
select p."customer_id",concat(c."first_name",' ',c."last_name")as nombre_clientes ,Sum(p."amount") total_gastado
from "payment" as p
inner join "customer" as c
on p."customer_id" = c."customer_id"
group by p."customer_id", concat(c."first_name",' ',c."last_name")
order by total_gastado desc
limit 5;

--Enunciado 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'
select "first_name" , "last_name"
from "actor"
where "first_name"='JOHNNY';

--Enunciado 36.Renombra la columna “first_name” como Nombre y “last_name” como Apellido
select "first_name" as Nombre, "last_name" as Apellido
from "actor";

--Enunciado 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN("actor_id") as actor_mas_bajo , MAX("actor_id") as actor_mas_alto
from "actor";

--Enunciado 38. Cuenta cuántos actores hay en la tabla “actor”.
select count("actor_id") as actores_totales
from "actor";

--Enunciado 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select  Concat("first_name", ' ', "last_name") as nombre_completo
from "actor"
order by "last_name" asc;

--Enunciado 40. Selecciona las primeras 5 películas de la tabla “film”
select "film_id","title"
from "film"
order by "film_id"
limit 5;

--Enunciado 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select count("first_name") as recuento_actores, "first_name"
from "actor"
group by "first_name"
order by count("first_name") desc ; --Kenneth, Penelope y Julia los nombres mas repetidos con 4 veces

--Enunciado 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select Concat(c."first_name",' ',"last_name") as nombre_cliente , "rental_id"
from "rental" as r
left join "customer" as c
on r."customer_id" = c."customer_id";


--Enunciado 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select Concat(c."first_name",' ',"last_name") as nombre_cliente ,count  (r."rental_id") as total_alquileres
from "rental" as r
left join "customer" as c
on r."customer_id" = c."customer_id"
group by Concat(c."first_name",' ',"last_name")
order by total_alquileres asc;

--Enunciado 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from "film" as f
cross join "category" as c; 
--El CROSS JOIN entre film y category no aporta valor práctico en este caso, porque no refleja una relación real entre películas y categorías.
--Cada película aparece combinada con todas las categorías posibles, generando información redundante y sin sentido analítico.


--Enunciado 45. Encuentra los actores que han participado en películas de la categoría 'Action'
select c."name", Concat(a."first_name", ' ',a."last_name") as nombre_actor 
from "actor" as a
inner join "film_actor" as f
on a."actor_id" =f."actor_id"
inner join "film" as f2
on f."film_id"=f2."film_id"
inner join "film_category" as f3
on f2."film_id"=f3."film_id"
inner join "category" as c
on f3."category_id"=c."category_id"
where c."name"='Action'
group by c."name" , Concat(a."first_name", ' ',a."last_name");


--Enunciado 46. Encuentra todos los actores que no han participado en películas
select Concat(a."first_name",' ',"last_name") as nombre_actor ,count(f."film_id") as recuento_peliculas
from "actor" as a
left join "film_actor" as f
on a. "actor_id" = f."actor_id"
left join "film" as f2 
on f."film_id"=f2."film_id"
where f."film_id" is null 
group by Concat(a."first_name",' ',"last_name")
having count(f."film_id")= 0; --Todos los actores de la tabla han participado en alguna pelicula al menos

--Enunciado 47. Selecciona el nombre de los actores y la cantidad de películas en las  que han participado.
select Concat(a. "first_name",' ',"last_name") as nombre_completo , count(f. "film_id") as peliculas_totales
from "actor" as a
inner join "film_actor" as f
on a. "actor_id" = f."actor_id"
group by Concat(a. "first_name",' ',"last_name")
order by count(f. "film_id");

--Enunciado 48.Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select Concat(a. "first_name",' ',"last_name") as nombre_completo , count(f. "film_id") as peliculas_totales
from "actor" as a
inner join "film_actor" as f
on a. "actor_id" = f."actor_id"
group by Concat(a. "first_name",' ',"last_name")
order by count(f. "film_id");

--Enunciado 49. Calcula el número total de alquileres realizados por cada cliente.
select Concat(c."first_name",' ',"last_name") as nombre_completo, count(r."rental_id") as  total_num_alquileres
from "rental" as r
inner join "customer" as c 
on r."customer_id"=c."customer_id"
group by Concat(c."first_name",' ',"last_name")
order by total_num_alquileres;

--Enunciado 50. Calcula la duración total de las películas en la categoría 'Action'
select c."name", SUM(f."length") as duracion_total
from "film" as f
inner join "film_category" as f2
on f."film_id"=f2."film_id"
inner join "category" as c
on f2."category_id" = c."category_id"
where c."name"='Action'
group by c."name";

--Enunciado 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE cliente_rentas_temporal AS 
    SELECT 
        CONCAT(c."first_name", ' ', c."last_name") AS nombre_completo,
        COUNT(r."rental_id") AS total_num_alquileres
    FROM "rental" AS r
    INNER JOIN "customer" AS c 
        ON r."customer_id" = c."customer_id"
    GROUP BY CONCAT(c."first_name", ' ', c."last_name")
ORDER BY total_num_alquileres DESC;


--Enunciado 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces
CREATE TEMPORARY TABLE  peliculas_alquiladas as 
select f."title", Count(r."rental_id") as total_peliculas_alquiladas
from "rental" as r
inner join "inventory" as i
on r."inventory_id" =i."inventory_id"
inner join "film" as f
on i."film_id"=f."film_id"
group by f."title"
having Count(r."rental_id")>=10
order by total_peliculas_alquiladas;

--Enunciado 53.Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f."title", Concat(c."first_name",' ',"last_name") as nombre_cliente ,r."return_date"
from "customer" as c
inner join "rental" as r
on c."customer_id"=r."customer_id"
inner join "inventory" as i
on r."inventory_id"= i."inventory_id"
inner join "film" as f
on i."film_id"=f."film_id"
where Concat(c."first_name",' ',"last_name")= 'TAMMY SANDERS' AND r."return_date" is null
order by f."title";

--Enunciado 54.Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select a."first_name",a."last_name", c."name"
from "actor"as a
full join "film_actor" as f 
on a."actor_id" =f."actor_id"
full join "film" as f2
on f."film_id" =f2."film_id"
full join "film_category" as f3
on f2."film_id"=f3."film_id"
full join "category" as c
on f3."category_id"=c."category_id"
where c."name"='Sci-Fi'
group by a."first_name",a."last_name", c."name"
order by a."last_name";

--Enunciado 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido
SELECT DISTINCT 
    a."first_name" AS nombre,
    a."last_name" AS apellido,
     f."title" AS titulo_pelicula
FROM "actor" a
INNER JOIN "film_actor" fa
ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f
ON fa.film_id = f.film_id
INNER JOIN "inventory" i
ON f."film_id" = i."film_id"
INNER JOIN "rental" r 
ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
    SELECT MIN(r2."rental_date")
    FROM "rental" r2
    INNER JOIN "inventory" i2 ON r2."inventory_id" = i2."inventory_id"
    INNER JOIN "film"f2 ON i2."film_id" = f2."film_id"
    WHERE f2."title" = 'SPARTACUS CHEAPER'
)
group by a."first_name" , a."last_name" , f."title"
ORDER BY a."last_name" ASC, f."title" ASC;



--Enunciado 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select Concat(a."first_name",' ',"last_name") as nombre_actor , f2."title" , c."name"
from "actor"as a
full join "film_actor" as f 
on a."actor_id" =f."actor_id"
full join "film" as f2
on f."film_id" =f2."film_id"
full join "film_category" as f3
on f2."film_id"=f3."film_id"
full join "category" as c
on f3."category_id"=c."category_id"
where c."name" <>'Music'
group by f2."title" ,c."name",Concat(a."first_name",' ',"last_name");


--Enunciado 57.Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select "title", "rental_duration"
from "film"
where "rental_duration" >8;

--Enunciado 58.Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select f."title",c."name"
from "film" as f
inner join "film_category" as f2
on f."film_id" = f2."film_id"
inner join "category" as c
on f2."category_id" =c."category_id"
where c."name" ='Animation';

--Enunciado 59.Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select "title", "length"
from "film"
where "length"= (select "length" from "film" where "title"='DANCING FEVER')
order by "title" ASC;

--Enunciado60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select c."first_name",c."last_name" 
from "customer" as c
inner join "rental" as r
on c."customer_id"=r."customer_id"
inner join "inventory" as i
on r."inventory_id"=i."inventory_id"
group by c."first_name",c."last_name"
HAVING COUNT(DISTINCT i."film_id") >= 7
order by c."last_name";


--Enunciado 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name",Count(f."film_id") as total_peliculas ,Count(r."rental_id") as recuento_alquileres 
from "rental" as r
inner join "inventory" as i
on r."inventory_id"=i."inventory_id"
inner join "film" as f
on i."film_id"=f."film_id"
inner join "film_category" as f2
on f."film_id"=f2."film_id"
inner join "category" as c
on f2."category_id"=c."category_id"
group by c."name";

--Enunciado 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name", Count(f."film_id") as total_peliculas , f."release_year"
from "film" as f
inner join "film_category" as f2
on f."film_id"=f2."film_id"
inner join "category" as c
on f2."category_id" =c."category_id"
where f."release_year" ='2006'
group by c."name" , f."release_year"
order by total_peliculas;

--Enunciado 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from "staff" as s
cross join "store" as s2;

--Enunciado 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas
select c."customer_id", Concat(c."first_name",' ',"last_name") as nombre_completo, count(r."rental_id") as  total_num_alquileres
from "rental" as r
inner join "customer" as c 
on r."customer_id"=c."customer_id"
group by Concat(c."first_name",' ',"last_name"),c."customer_id"
order by total_num_alquileres;







