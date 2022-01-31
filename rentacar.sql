------------------------------------------Create and use Database  ------------------------------------

CREATE DATABASE RentACar;
USE RentACar;

					/*		Creating Table Customers		*/

CREATE TABLE Customers
(
	id int primary key identity,
	name nvarchar(20) not null,
	surname nvarchar(40) not null,
	phone nvarchar(30) not null,
	city nvarchar(20) not null,
	country nvarchar(20) not null,
	email nvarchar(50),
	address nvarchar(100),
	identity_card int references Customers(id)
)

					/*		Creating Table CarType		*/

CREATE TABLE CarType
(
	id int primary key identity,
	type_name nvarchar(20) not null
)

					/*		Creating Table Cars		*/

CREATE TABLE Cars
(
	id int primary key identity,
	brand nvarchar(20) not null,
	model nvarchar(20) not null,
	color nvarchar(30) default 'black',
	year nvarchar(4) not null,
	motor decimal(2, 1) default 0.0,
	type int references CarType(id),
	car_mileage int not null
)

					/*		Creating Table Branches		*/

CREATE TABLE Branches
(
	id int primary key identity,
	country nvarchar(20) not null,
	address nvarchar(50) not null,
	phone nvarchar(20) not null
)

					/*		Creating Table DailyPrice		*/

create table DailyPrice
(
	id int primary key identity,
	car_name int references Cars(id) not null,
	one_day_price int not null,
	three_day_price int not null,
	seven_day_price int not null
)

					/*		Creating Table Booking		*/

CREATE TABLE Booking
(
	id int primary key identity,
	pickup_date date not null default GETDATE(),
	return_date date not null default GETDATE(),
	pickup_branch int references Branches(id),
	return_branch int references Branches(id),
	customer_id int references Customers(id),
	car_id int references Cars(id),
	amount int not null
)

------------------------------------------Insert values  ------------------------------------

					/*		Insert Data	Customers		*/

insert into Customers(name, surname, phone, city, country, email, address) values
('Elnur', 'Maharramli', '111-11-11', 'Helsinki', 'Finland', 'elnur@maharramli.az', 'Address 1'),
('Akif', 'Talibov', '222-22-22', 'Baku', 'Azerbaycan', 'akif@talibov.az', 'Address 2'),
('Orxan', 'Nasibli', '333-33-33', 'London', 'England', 'orxan@nasibli.az', 'Address 3'),
('Sabir', 'Amirli', '444-44-44', 'Stockholm', 'Sweden', 'sabir@amirli.az', 'Address 4'),
('Madat', 'Nazaraliyev', '555-55-55', 'Dublin', 'Ireland', 'madat@nazaraliyev.az', 'Address 5'),
('Xeyali', 'Mammadov', '666-66-66', 'Stockholm', 'Sweden', 'xeyali@mammadov.az', 'Address 6')

					/*		Insert Data	Branches		*/

insert into Branches
values
('Finland', 'Address 1', '111-11-11'),
('Azerbaycan', 'Address 2', '222-22-22'),
('England', 'Address 3', '333-33-33'),
('Sweden', 'Address 4', '444-44-44'),
('Ireland', 'Address 5', '555-55-55')

					/*		Insert Data	CarTypes		*/

insert into CarType
values
('Offroader'),
('Sedan'),
('Kupe'),
('Van'),
('Hatchback')

					/*		Insert Data	Cars		*/

insert into Cars
values
('Mercedes', 'B 170', 'white', 2007, 1.7, 5, 72605),
('Chevrolet', 'Captiva', 'black', 2021, 1.5, 1, 0),
('Mercedes', 'E 240', 'blue', 2000, 2.4, 2, 311000),
('Land Rover', 'Range Rover', 'black', 2020, 2.0, 1, 0),
('Dodge', 'Challenger', 'pacific blue', 2019, 3.6, 3, 15000),
('Mercedes', 'Vito', 'black', 2016, 2.2, 4, 141000),
('Rolls-Royce', 'Wraith', 'black', 2016, 6.5, 3, 4300),
('Mazda', '6', 'grey', 2021, 2.5, 2, 0),
('Mazda', 'XC-9', 'black', 2018, 2.5, 1, 135000),
('Mazda', '2', 'black', 2015, 1.5, 5, 148000),
('Kia', 'Sorento', 'grey', 2015, 2.0, 1, 178000),
('Kia', 'Rio', 'dark grey', 2015, 1.6, 2, 46000)

					/*		Insert Data	Booking		*/

insert into DailyPrice
values
(1, 60, 55, 50),
(2, 90, 85, 80),
(3, 70, 65, 60),
(4, 200, 195, 190),
(5, 140, 135, 130),
(6, 120, 115, 110),
(7, 250, 230, 210),
(8, 180, 175, 170),
(9, 200, 195, 190),
(10, 140, 135, 130),
(11, 120, 115, 110),
(12, 60, 55, 50)

					/*		Insert Data	Booking		*/

insert into Booking(pickup_date, return_date, pickup_branch, return_branch, customer_id, car_id, amount)
values
('2021-12-20', '2022-01-03', 1, 1, 1, 7, 240),
('2022-01-01', '2022-01-04', 2, 2, 2, 5, 135),
('2022-01-05', '2022-01-12', 3, 3, 3, 4, 190),
('2022-01-03', '2022-01-04', 4, 4, 4, 2, 90),
('2022-01-20', '2022-01-23', 5, 5, 5, 12, 55),
('2021-12-10', '2022-01-01', 4, 4, 6, 8, 510)


------------------------------------------Tasks  ------------------------------------

					/*		Create View		*/


--create view v_BookingInfo
--as

--select C.name, C.surname, pickup_date, return_date, BR.address, CR.brand, CR.model, amount from Booking B

--join Customers C
--on B.customer_id = C.id

--join Branches BR
--on B.pickup_branch = BR.id

--join Cars CR
--on B.car_id = CR.id

					/*		Create Procedure		*/

--create procedure GetByAmount @Amount int
--as
--begin
--	select * from v_BookingInfo
--	where amount >= @Amount
--end

execute GetByAmount 100

					/*		Create Function		*/

--create function GetSumOfAmount(@Amount int)
--returns int
--as
--begin
--	declare @Sum int
--	select @Sum = Sum(amount) from v_BookingInfo
--	where amount = @Amount
--	return @Sum
--end

select dbo.GetSumOfAmount(240)

--create function GetByCarName(@Car_name nvarchar(20))
--returns table
--as
--return
--select * from Cars where brand = @Car_name

select * from GetByCarName('Mercedes')

--create function GetByPhoneNumber(@PhoneNumber nvarchar(30))
--returns table
--as
--return select * from Customers where phone = @PhoneNumber

select * from GetByPhoneNumber('111-11-11')

					/*		Create Trigger		*/

alter table Customers
add IsDisabled bit not null default 0;

select * from Customers


--create trigger SoftDelete on Customers
--instead of delete
--as
--begin
--	update Customers
--	set IsDisabled = 1
--	where id = (select id from deleted)
--	select * from Customers
--end

delete from Customers
where name like 'Elnur'
