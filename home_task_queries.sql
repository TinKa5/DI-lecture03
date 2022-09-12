/*
 Завдання на SQL до лекції 02.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.*/

select fc.category_id, category.name, count(1) as count from category
    join film_category fc on category.category_id = fc.category_id
    join film f on f.film_id = fc.film_id
group by fc.category_id, category.name
order by count desc




/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
select a.first_name, a.last_name, count(1) as count from actor as a
    join film_actor fa on a.actor_id = fa.actor_id
    join inventory i on fa.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
group by a.first_name, a.last_name
order by count desc
limit 10



/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/

select c.name, sum(p.amount) as amount from category as c
    join film_category fc on c.category_id = fc.category_id
    join inventory i on fc.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
    join payment p on r.rental_id = p.rental_id
group by c.name
order by amount desc
limit 1


/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
select f.title, i.film_id from film as f
    left join inventory i on f.film_id = i.film_id
                            where i.film_id is null
group by f.film_id, i.film_id
order by f.film_id



/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
select a.first_name, a.last_name, count(1) as count from category as c
    inner join film_category fc on c.category_id = fc.category_id and c.name = 'Children'
    inner join film_actor fa on fc.film_id = fa.film_id
    inner join actor a on a.actor_id = fa.actor_id
group by a.first_name, a.last_name
order by count desc
limit 3


/*
6.
Вивести міста з кількістю активних та неактивних клієнтів
(в активних customer.active = 1).
Результат відсортувати за кількістю неактивних клієнтів за спаданням.
*/
select c.city, sum(case when c2.active=1 then 1 else 0 end) as active,
       sum(case when c2.active=0 then 1 else 0 end) as notActive from city as c
    join address a on c.city_id = a.city_id
    join customer c2 on a.address_id = c2.address_id
group by c.city
order by notActive desc