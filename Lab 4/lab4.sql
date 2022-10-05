--1
select * from region r;

--2.1
select r.region_description, t.territory_description 
from region r inner join territories t 
on r.region_id = t.region_id;

--2.2
select r.region_description , count(et.employee_id)
from region r inner join (territories t inner join employee_territories et on t.territory_id = et.territory_id) 
on r.region_id = t.region_id
group by r.region_id;

--3
select r.region_description , t.territory_description , count(et.employee_id)
from region r inner join (territories t inner join employee_territories et on t.territory_id = et.territory_id) 
on r.region_id = t.region_id
group by r.region_id, t.territory_id;

--4
select e.first_name , e.last_name 
from employees e inner join (employee_territories et inner join territories t on t.territory_id = et.territory_id) 
on e.employee_id = et.employee_id 
where t.territory_description = 'Orlando';

--5
select count(*) 
from customers c 
where c.country != 'USA';

--6
select *
from products p
where p.units_in_stock < p.reorder_level
order by p.units_in_stock;

--7
select sum(od.quantity * od.unit_price * (1 - od.discount))
from order_details od
where od.order_id = '11077'
group by od.order_id;

-- 8
select p.product_name
from products p inner join (orders o inner join order_details od on od.order_id = o.order_id) 
on p.product_id = od.product_id 
where o.order_date < '1998-05-06' and o.order_date > '1998-04-06'
group by p.product_id 
order by sum(od.quantity) desc 
limit 1;

-- 9
select o.ship_country , sum(od.quantity)
from products p inner join (orders o inner join order_details od on od.order_id = o.order_id) 
on p.product_id = od.product_id 
where o.ship_country != 'USA'
group by o.ship_country;

-- 10
select c.category_name , sum(od.quantity)
from categories c, products p, order_details od, orders o
where od.order_id = o.order_id and p.product_id = od.product_id and 
p.category_id = c.category_id and o.ship_country = 'France'
group by c.category_name;

--11
select *
from customers c 
where c.fax is null;

-- 12
select e.*
from employees e inner join orders o on e.employee_id = o.employee_id 
where extract(year from o.order_date) = '1998'
group by e.employee_id 
order by count(*) desc 
limit 3;

-- 13
select distinct s
from shippers s
where exists (select *
from orders o 
where o.ship_via = s.shipper_id and o.ship_country = 'France') and 
exists (select *
from orders o 
where o.ship_via = s.shipper_id and o.ship_country = 'Germany');

-- 14
with categorySentToGermany(category_id) as (
select distinct p.category_id 
from products p, order_details od, orders o
where od.order_id = o.order_id and p.product_id = od.product_id and o.ship_country = 'Germany')
select c.category_name
from categories c
where c.category_id not in (select category_id from categorySentToGermany);

-- 15
update employees e
set city = 'New York'
where city = 'Orlando';

-- 16
create view employees_age as
select *, age(e.birth_date) as age
from employees e;

select t.region_id, avg(e.age) 
from employees_age e, employee_territories et, territories t
where et.territory_id = t.territory_id and et.employee_id = e.employee_id
group by(t.region_id);

-- 17
with q as (
		select c.contact_name  || ' - ' || c.contact_title as "customer",
to_char(order_date, 'month') as "month", sum(od.unit_price * od.quantity * (1 - od.discount)) as "total_paid" 
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join order_details od on o.order_id = od.order_id
where order_date >= to_date('1997','YYYY') and order_date < to_date('1998','YYYY') 
group by "customer", "month"
)
select t.customer, t.month, t.total_paid
from (
select *, row_number () over (partition by "month" order by total_paid desc ) as "rank" from q) as t
where "rank" <= 5;
