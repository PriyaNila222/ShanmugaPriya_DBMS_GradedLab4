create database ECommerce;
use ECommerce;
create table if not exists Supplier
(
	Supp_ID int not null,
	Supp_Name varchar(50) not null,
	Supp_City varchar(50) not null,
	Supp_Phone varchar(50) not null,
	primary key(Supp_ID)
);

create table if not exists Customer
(
	Cus_ID int not null,
	Cus_Name varchar(50) not null,
	Cus_Phone varchar(10) not null,
	Cus_City varchar(30) not null,
	Cus_Gender char,
	primary key(Cus_ID)
);

create table if not exists Category
(
	cat_ID int not null,
	Cat_Name varchar(20) not null,
	primary key(Cat_ID)
);

create table if not exists Product
(
	Pro_ID int not null,
	Pro_Name varchar(20) not null default "Dummy",
	Pro_Desc varchar(60),
	Cat_ID int not null,
	primary key(Pro_ID),
	foreign key(Cat_ID) references Category(Cat_ID)
);

create table if not exists Supplier_Pricing
(
	Pricing_ID int not null,
	Pro_ID int not null,
	Supp_ID int not null,
	Supp_Price int default 0,
	primary key(Pricing_ID),
	foreign key(Pro_ID) references Product(Pro_ID),
	foreign key(Supp_ID) references Supplier(Supp_ID)
);

create table if not exists `Order`
(
	Ord_ID int not null ,
	Ord_Amount int not null,
	Ord_Date date,
	Cus_ID int not null,
	Pricing_ID int not null,
	primary key(Ord_ID),
	foreign key(Cus_ID) references Customer(Cus_ID),
	foreign key(Pricing_ID) references Supplier_Pricing(Pricing_ID)
);

create table if not exists Rating
(
	Rat_ID int not null,
	Ord_ID int not null,
	Rat_Ratstars int not null,
	primary key(Rat_ID),
	foreign key(Ord_ID) references `Order`(Ord_ID)
);

insert into Supplier(Supp_ID, Supp_Name, Supp_City, Supp_Phone) values
(1,'Rajesh Retails','Delhi','1234567890'),
(2,'Appario Ltd.','Mumbai','2589631470'),
(3,'Knome products','Banglore','9785462315'),
(4,'Bansal Retails','Kochi','8975463285'),
(5,'Mittal Ltd.','Lucknow','7898456532');

insert into Customer(Cus_ID, Cus_Name, Cus_Phone, Cus_City, Cus_Gender) values
(1,'AAKASH','9999999999','DELHI','M'),
(2,'AMAN','9785463215','NOIDA','M'),
(3,'NEHA','9999999999','MUMBAI','F'),
(4,'MEGHA','9994562399','KOLKATA','F'),
(5,'PULKIT','7895999999','LUCKNOW','M');

insert into Category(Cat_ID, Cat_Name) values 
(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');

insert into Product(Pro_ID, Pro_Name, Pro_Desc, Cat_ID) values
(1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2),
(2,'TSHIRT','SIZE-L with Black, Blue and White variations',5),
(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
(4,'OATS','Highly Nutritious from Nestle',3),
(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
(6,'MILK','1L Toned MIlk',3),
(7,'Boat Earphones','1.5Meter long Dolby Atmos',4),
(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
(9,'Project IGI','compatible with windows 7 and above',2),
(10,'Hoodie','Black GUCCI for 13 yrs and above',5),
(11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
(12,'Train Your Brain','By Shireen Stephen',1);

insert into Supplier_Pricing(Pricing_ID, Pro_ID, Supp_ID, Supp_Price) values
(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000),
(6,12,2,780),
(7,12,4,789),
(8,3,1,31000),
(9,1,5,1450),
(10,4,2,999),
(11,7,3,549),
(12,7,4,529),
(13,6,2,105),
(14,6,1,99),
(15,2,5,2999),
(16,5,2,2999);

insert into `Order` (Ord_ID, Ord_Amount, Ord_Date, Cus_ID, Pricing_ID) values 
(101,1500,"2021-10-06",2,1),
(102,1000,"2021-10-12",3,5),
(103,30000,"2021-09-16",5,2),
(104,1500,"2021-10-05",1,1),
(105,3000,"2021-08-16",4,3),
(106,1450,"2021-08-18",1,9),
(107,789,"2021-09-01",3,7),
(108,780,"2021-09-07",5,6),
(109,3000,"2021-09-10",5,3),
(110,2500,"2021-09-10",2,4),
(111,1000,"2021-09-15",4,5),
(112,789,"2021-09-16",4,7),
(113,31000,"2021-09-16",1,8),
(114,1000,"2021-09-16",3,5),
(115,3000,"2021-09-16",5,3),
(116,99,"2021-09-17",2,14);

insert into Rating(Rat_ID, Ord_ID, Rat_Ratstars) values
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);

-- Q3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
select t2.Cus_Gender as Gender, count(t2.Cus_Gender) as TotalNoOfCustomer from
(
	select t1.Cus_Gender, count(t1.Cus_Gender) as Total from
	(
		select ord.Cus_ID, cust.Cus_Gender 
		from `Order` ord 
		inner join Customer cust on 
		ord.Cus_ID = cust.Cus_ID 
		where ord.Ord_Amount >= 3000
	) 
	as t1
	group by t1.Cus_ID
) as t2 
group by t2.Cus_Gender;

-- Q4) Display all the orders along with product name ordered by a customer having Customer_Id=2
select ord.*, prd.Pro_Name 
from `Order` ord 
inner join Supplier_Pricing supp 
on ord.Pricing_ID = supp.Pricing_ID
inner join Product prd 
on prd.Pro_ID = supp.Pro_ID 
where ord.Cus_ID = 2;

-- Q5)Display the Supplier details of who is supplying more than one product.
select * from Supplier sp 
inner join
(
	select supp.supp_ID, count(supp.Pro_ID) as count 
    from Supplier_Pricing supp 
    group by supp.Supp_ID
) 
as t1 
on t1.Supp_ID = sp.Supp_ID 
where t1.count > 1;

-- Q6)Find the least expensive product from each category and print the table with 
-- category id, name, and price of the product
select c.cat_id as Category_ID,c.cat_name as Name, min(t1.min_price) as Price 
from category c 
inner join
(
	select prd.cat_id, prd.pro_name, t2.* 
	from product prd 
    inner join  
	(
		select supp.pro_id, min(supp.supp_price) as Min_Price 
        from supplier_pricing supp 
        group by supp.pro_id
	) 
	as t2 
    where t2.pro_id = prd.pro_id
)
as t1 
where t1.cat_id = c.cat_id 
group by t1.cat_id;

-- Q7)Display the Id and Name of the Product ordered after “2021-10-05”. 
select prd.pro_id as ID,prd.pro_name as Name from `order` ord 
inner join supplier_pricing supp 
on supp.pricing_id=ord.pricing_id 
inner join product prd
on prd.pro_id=supp.pro_id 
where ord.ord_date>"2021-10-05";

-- Q8)Display customer name and gender whose names start or end with character 'A'.
select cust.cus_name as Customer_Name,cust.cus_gender as Gender
from customer cust 
where cust.cus_name like 'A%' 
or 
cust.cus_name like '%A';

-- Q9)Create a stored procedure to display supplier id, name, 
-- Rating(Average rating of all the products sold by every customer) and Type_of_Service. 
-- For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
-- If rating >2 print “Average Service” else print “Poor Service”. 
-- Note that there should be one rating per supplier.

delimiter &&  
create procedure GetDetails()
begin
select report.supp_id as Supplier_ID,report.supp_name as Name,report.Rating as Rating,
case	
	When Rating = 5 then 'Excellent Service'
	When Rating > 4 then 'Good Service'
	WHEN Rating > 2 then 'Average Service'
	ELSE 'poor service'
end as Type_of_Service from 
(
	select s.Supp_ID, s.Supp_Name, t1.avg as Rating
    from Supplier s
    inner join
    (
		select supp.Supp_ID, avg(rt.Rat_Ratstars) as avg
        from `Order` ord
        inner join rating rt 
        on rt. Ord_ID = ord.Ord_ID
        inner join Supplier_Pricing supp
        on supp.Pricing_ID = ord.Pricing_ID
        group by supp.Supp_ID
        
	)
    as t1
    on t1.Supp_ID = s.Supp_ID		
) 
as report;
end &&  
delimiter ;  

call GetDetails();




