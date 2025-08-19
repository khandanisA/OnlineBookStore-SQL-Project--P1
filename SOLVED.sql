--Create Database
create database OnlineBookStoreDB;

--Create Tables
drop table if exists books;

create table books(Book_ID serial primary key,
                   Title varchar(150) not null,
				   Author varchar(150) not null,
				   Genre varchar(150) not null,
				   Published_Year int not null,
				   Price numeric not null,
				   Stock int not null
				   );

drop table if exists customers;	
create table customers(Customer_ID serial primary key,
                       Name varchar(100) not null,
					   Email varchar(200) not null,
					   Phone int,
					   City varchar(100) not null,
					   Country varchar(100) not null
					   ); 

drop table if exists orders;
create table orders(Order_ID serial primary key,
                    Customer_ID int not null,
					Book_ID int not null,
					Order_Date date not null,
					Quantity int not null,
					Total_Amount numeric,
					foreign key(customer_id) references customers(customer_id),
					foreign key(book_id) references books(book_id)
                   );

--Import Data into Books table				   
copy
customers(Customer_ID,Name,Email,Phone,City,Country)
from '‪C:\Users\MD DANISH KHAN\OneDrive\Desktop\Customers.csv'
delimiter','
csv header;

copy orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
from '‪C:\Users\MD DANISH KHAN\OneDrive\Desktop\Orders.csv'
delimiter ','
csv header;

copy books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
from '‪C:\Users\MD DANISH KHAN\OneDrive\Desktop\Books.csv'
delimiter ','
csv header;

--1) Retrieve all books in the "Fiction" genre
 select * from books
 where genre ='Fiction';

--2) Find books published after the year 1950
select * from books
where published_year > 1950;

--3) List all customers from the Canada
select * from customers
where country = 'Canada';

--4) Show orders placed in November 2023
select * from orders
where order_date between '2023-11-01' and '2023-11-30';
                      ---OR---
select * from orders
where order_date >='2023-11-01' and order_date <'2023-12-01';

--5) Retrieve the total stock of books 
select sum(stock) as total_stock
from books;

--6) Find the details of the most expensive book
select * from books 
order by price desc
limit 1;

--7) Show all customers who ordered more than 1 quantity of a book
select * from orders
where quantity > 1;

--8) Retrieve all orders where the total amount exceeds $20
select * from orders
where total_amount > 20;

--9) List all genres available in the Books table
select distinct(genre) from books;

--10) Find the book with the lowest stock
select * from books
order by stock
limit 1;

--11) Calculate the total revenue generated from all orders
select sum(total_amount) as total_revenue  from orders;

               ---- Advance Questions ---- 

-- 1) Retrieve the total number of books sold for each genre:
select b.genre,
	   sum(o.quantity) as total_books_sold
from books b
join orders o on b.book_id=o.book_id
group by b.genre
order by b.genre;

--2) Find the average price of books in the "Fantasy" genre
select avg(price) as average_price
from books
where genre='Fantasy';

--3) List customers who have placed at least 2 orders
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS number_of_orders
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(O.Order_id) >=2;

--4) Find the most frequently ordered book
select o.book_id,
       b.title,
	   count(o.order_id) as orders_count
from orders o join books b 
on o.book_id=b.book_id
group by o.book_id,b.title
order by orders_count desc
limit 1;

--5) Show the top 3 most expensive books of 'Fantasy' Genre 
select * from books
where genre='Fantasy'
order by price desc
limit 3;

--6) Retrieve the total quantity of books sold by each author
select b.author,
       sum(quantity) as total_quantity_of_books_sold
from books b
join orders o on b.book_id=o.book_id
group by b.author
order by total_quantity_of_books_sold;

--7) List the cities where customers who spent over $30 are located
select distinct(c.city),o.total_amount from customers c
join orders o on c.customer_id=o.customer_id
where o.total_amount > 30
order by total_amount;

--8) Find the customer who spent the most on orders
select o.customer_id,
       c.name,
       sum(o.total_amount) as most_spent_customer
from orders o join customers c on o.customer_id=c.customer_id
group by o.customer_id,c.name
order by most_spent_customer desc 
limit 1;




