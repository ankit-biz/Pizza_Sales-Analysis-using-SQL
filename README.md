# Pizza Sales Data Analysis

![Sales_Pizza_banner](https://github.com/user-attachments/assets/93b46a36-827f-458b-91a3-c1e10d1f7750)


## Project Overview

The **Pizza Sales Data Analysis** project involves building and analyzing a relational database, **pizza\_db**, to gain insights into the sales trends of a fictional pizza business. This analysis leverages SQL queries to uncover patterns, optimize decision-making, and improve business strategies.

---

## Database Structure

### Tables

1. **orders**

   - **Description:** Tracks order information, including order ID, date, and time.
   - **Columns:**
     - `order_id` (Primary Key): Unique identifier for each order.
     - `order_date`: Date of the order.
     - `order_time`: Time of the order.

2. **order\_details**

   - **Description:** Contains detailed information about the items in each order.
   - **Columns:**
     - `order_details_id` (Primary Key): Unique identifier for each order detail.
     - `order_id` (Foreign Key): References `order_id` in the `orders` table.
     - `pizza_id`: Identifier for the ordered pizza.
     - `quantity`: Number of pizzas ordered.

3. **pizzas**

   - **Description:** Stores pizza details, including size and price.
   - **Columns:**
     - `pizza_id` (Primary Key): Unique identifier for each pizza.
     - `size`: Size of the pizza (e.g., Small, Medium, Large).
     - `price`: Price of the pizza.

4. **pizza\_types**

   - **Description:** Lists the different pizza types and their categories.
   - **Columns:**
     - `pizza_type_id` (Primary Key): Unique identifier for each pizza type.
     - `name`: Name of the pizza type.
     - `category`: Category of the pizza (e.g., Veg, Non-Veg).

---

## Key Findings

1. **Total Orders Placed:**

   - **Query:**
     ```sql
     SELECT COUNT(order_id) AS total_order_placed FROM orders;
     ```

2. **Total Revenue Generated:**

   - **Query:**
     ```sql
     SELECT ROUND(SUM(quantity * price), 2)
     FROM pizzas
     INNER JOIN order_details ON pizzas.pizza_id = order_details.pizza_id;
     ```

3. **Highest-Priced Pizza:**

   - **Query:**
     ```sql
     SELECT name, price
     FROM pizzas
     JOIN pizza_types
     ORDER BY price DESC
     LIMIT 1;
     ```

4. **Most Common Pizza Size Ordered:**

   - **Query:**
     ```sql
     SELECT size, COUNT(size)
     FROM pizzas
     JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
     GROUP BY size
     ORDER BY COUNT(size) DESC;
     ```

5. **Top 5 Most Ordered Pizza Types:**

   - **Query:**
     ```sql
     SELECT name, SUM(quantity) AS quantity
     FROM pizza_types
     JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
     JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
     GROUP BY name
     ORDER BY quantity DESC
     LIMIT 5;
     ```

6. **Category-Wise Pizza Order Distribution:**

   - **Query:**
     ```sql
     SELECT category, SUM(quantity)
     FROM pizza_types
     JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
     JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
     GROUP BY category;
     ```

7. **Order Distribution by Hour:**

   - **Query:**
     ```sql
     SELECT HOUR(order_time), COUNT(order_id)
     FROM orders
     GROUP BY HOUR(order_time)
     ORDER BY COUNT(order_id) DESC;
     ```

8. **Top 3 Pizza Types by Revenue:**

   - **Query:**
     ```sql
     SELECT name, SUM(price * quantity) AS revenue
     FROM pizza_types
     JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
     JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
     GROUP BY name
     ORDER BY revenue DESC
     LIMIT 3;
     ```

---

## Tools and Technologies

- **Database Management:** MySQL
- **Data Analysis:** SQL
- **Visualization:** Optional tools like Tableau or Matplotlib for presenting insights

---

## How to Use

1. **Database Setup:**

   - Create the database using:
     ```sql
     CREATE DATABASE pizza_db;
     ```
   - Populate the database with the required tables and data.

2. **Execute Queries:**

   - Run the provided SQL queries to generate insights.

3. **Analyze Results:**

   - Interpret the findings to understand sales patterns and customer preferences.

---

## Conclusion

This project demonstrates the power of SQL in analyzing business data to uncover actionable insights. The results can help optimize menu offerings, boost revenue, and enhance customer satisfaction.
