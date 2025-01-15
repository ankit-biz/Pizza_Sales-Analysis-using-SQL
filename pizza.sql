create database pizza_db;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME
);

CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL
);

-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_order_placed
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(quantity * price), 2)
FROM
    pizzas
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
    
-- Identify the highest-priced pizza.
SELECT 
    name, price
FROM
    pizzas
        JOIN
    pizza_types
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    size, COUNT(size)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY COUNT(size) DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, SUM(quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    category, SUM(quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
select hour(order_time), count(order_id) from orders group by hour(order_time) order by count(order_id) desc ;

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    order_date, ROUND(COUNT(order_details_id)) AS Order_per_day
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY order_date;

-- Determine the top 3 most ordered pizza types based on revenue.

select name, sum(price*quantity) as revenue from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details on pizzas.pizza_id=order_details.pizza_id group by name order by sum(price*quantity) desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

select category, round(sum(price*quantity) / (select SUM(quantity * price)
FROM
    pizzas
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id)*100)  as revenue from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details on pizzas.pizza_id=order_details.pizza_id group by category;