select distinct s.company_name, count(*) 
over (partition by s.company_name)
from shippers s, orders o
where o.ship_via = s.shipper_id;

select distinct c.category_name, p.product_name, p.unit_price, 
	rank() over(partition by c.category_name order by p.unit_price desc)
from products p, categories c
where c.category_id = p.category_id and c.category_name = 'Seafood'
order by rank;

select od.order_id, od.quantity*od.unit_price*(1-od.discount) as total,
	percent_rank() over (order by od.quantity*od.unit_price*(1-od.discount)) 
from order_details od
order by percent_rank desc;