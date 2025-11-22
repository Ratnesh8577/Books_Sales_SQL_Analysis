-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
Use online_Bookstore

-- Create Tables

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
-- COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
-- FROM 'D:/Users/ratneshchauhan/Downloads/Project/sql-project-10---sql-mentor-datasets-main/Books.csv'
-- csv header

-- 1) Retrieve all books in the "Fiction" genre:
select * from Books 
where genre="Fiction"



-- 2) Find books published after the year 1950:
select * from Books
where Publish_Year>1950


-- 3) List all customers from the Canada:
select * from Customers
where Country ="Canada";


-- 4) Show orders placed in November 2023:
select * from Orders
where Order_Date between '2023-11-01' and '2023-11-30'


-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_Stock
from Books


-- 6) Find the details of the most expensive book:
select max(Price) as Most_Expensive_Book
from Books 

select * from Books 
order by Price  DESC 
limit 1


-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from Orders
where Quantity>1


-- 8) Retrieve all orders where the total amount exceeds $20:
select * from Orders
where Total_Amount>20


-- 9) List all genres available in the Books table:
select DISTINCT genre from Books



-- 10) Find the book with the lowest stock:
select min(Stock) from Books 

select * from Books 
order by Stock 

select * from Books 
order by Stock 
limit 1


-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as Revenue from Orders 


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
selcect * from Orders

select b.genre,sum(o.Quantity) as Total_Books_Sold
from Orders o
join Books b
on o.Book_ID = b.Book_ID
group by b.genre




-- 2) Find the average price of books in the "Fantasy" genre:
select avg(Price) as Average_Price
from Books
where genre="Fantasy"



-- 3) List customers who have placed at least 2 orders:
select Customer_ID ,count(Order_ID) as Order_Count
from Orders
group by Customer_ID
having count(Order_ID) >=2


select o.Customer_ID,c.Name,count(o.Order_ID) as Order_Count
from Orders o
join Customers c
on o.Customer_ID= c.Customer_ID
group by Customer_ID
having count(Order_ID) >=2

-- 4) Find the most frequently ordered book:

select b.Book_ID,b.Title,count(o.Order_ID) as order_count
from Orders o
join Books b
on o.Book_ID=b.Book_ID
group by Book_ID
order by order_count desc
limit 1


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from Books
where genre ="Fantasy"
order by price Desc
limit 3



-- 6) Retrieve the total quantity of books sold by each author:

select b.Author, sum(o.Quantity) as Total_Books_Sold
from Orders o
join Books b 
on o.Book_ID = b.Book_ID
group by b.Author


-- 7) List the cities where customers who spent over $30 are located:

select distinct(c.City),c.Name,o.Total_Amount
from Orders o
join Customers c 
on c.Customer_ID = o.Customer_ID
where o.Total_Amount>30





-- 8) Find the customer who spent the most on orders:

select c.Customer_ID,c.Name,Sum(o.Total_Amount) as Total_Spent
from Orders o
join Customers c
on o.Customer_ID=c.Customer_ID
group by c.Customer_ID,c.Name
order by Total_Spent DESC 
limit 1



-- 9) Calculate the stock remaining after fulfilling all orders:

select b.Book_ID,b.Title,b.Stock,coalesce(sum(o.Quantity),0) as Order_Quantity,
Stock-coalesce(sum(o.Quantity),0) as Remainig_Quantity
from Books b
left join Orders o
on b.Book_ID=o.Book_ID
group by b.Book_ID










