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


