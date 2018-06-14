CREATE TABLE Hotel (Hotel_No varchar(5) PRIMARY KEY,Name varchar(50),City varchar(50)); 

CREATE TABLE Room(Room_No int PRIMARY KEY, Hotel_No varchar(5),Hotel_type varchar(50), Price int, FOREIGN KEY(Hotel_No) REFERENCES Hotel(Hotel_No));

CREATE TABLE Guest (Guest_No varchar(5) PRIMARY KEY,Name varchar(50),City varchar(50));

CREATE TABLE Booking(Hotel_No varchar(5), Guest_No varchar(5),Date_From date PRIMARY KEY, Date_To date,Room_No int, FOREIGN KEY(Hotel_No) REFERENCES Hotel(Hotel_No),FOREIGN KEY(Guest_No) REFERENCES Guest(Guest_No),FOREIGN KEY(Room_No) REFERENCES Room(Room_No));


insert into Hotel values('H111','Empire Hotel','New York');
insert into Hotel values('H235','Park Place','New York');
insert into Hotel values('H432','Brownstone Hotel','Toronto');
insert into Hotel values('H498','James Hotel','Toronto');
insert into Hotel values('H193','Devon Hotel','Boston');
insert into Hotel values('H437','Clairmont Hotel','Boston');

insert into Room values(313,'H111','S',145);
insert into Room values(412,'H111','N',145);
insert into Room values(1267,'H235','N',175);
insert into Room values(1289,'H235','N',195);
insert into Room values(876,'H432','S',124);
insert into Room values(898,'H432','S',124);
insert into Room values(345,'H498','N',160);
insert into Room values(467,'H498','N',180);
insert into Room values(1001,'H193','S',150);
insert into Room values(1201,'H193','N',175);
insert into Room values(257,'H437','N',140);
insert into Room values(223,'H437','N',155);

insert into Booking values('H111','G256',10-AUG-99,15-AUG-99,412);
insert into Booking values('H111','G367',18-AUG-99,21-AUG-99,412);
insert into Booking values('H235','G897',05-SEP-99,12-SEP-99,1267);
insert into Booking values('H498','G230',15-SEP-99,18-SEP-99,467);
insert into Booking values('H498','G256',30-NOV-99,02-DEC-99,345);
insert into Booking values('H498','G467',03-NOV-99,05-NOV-99,345);
insert into Booking values('H193','G190',15-NOV-99,19-NOV-99,1001);
insert into Booking values('H193','G367',12-SEP-99,14-SEP-99,1001);
insert into Booking values('H193','G367',01-OCT-99,06-OCT-99,1201);
insert into Booking values('H437','G190',02-OCT-99,06-OCT-99,223);
insert into Booking values('H437','G879',14-SEP-99,17-SEP-99,223);

INSERT INTO GUEST VALUES('G256','Adam Wayne','Pittsburgh');
INSERT INTO GUEST VALUES('G367','Tara Cummings','Baltimore');
INSERT INTO GUEST VALUES('G879','Vanessa Parry','Pittsburgh');
INSERT INTO GUEST VALUES('G230','Tom Hancock','Philadelphia');
INSERT INTO GUEST VALUES('G467','Robesrt Swift','Atlanta');
INSERT INTO GUEST VALUES('G190','Edward Cane','Baltimore');


/*List full details of all hotels.*/
select * from hotel;

/*List full details of all hotels in New York.*/
select * from hotel where city='New York';

/*List the names and cities of all guests, ordered according to their cities.*/
select name, city from guest order by city;

/*List all details for non-smoking rooms in ascending order of price.*/
select * from room where hotel_type='N' order by price;

/*List the number of hotels there are.*/
select count(*) from hotel;

/*List the cities in which guests live. Each city should be listed only once.*/
select distinct city from guest;

/*List the average price of a room.*/
select AVG(Price) FROM room; 

/*List hotel names, their room numbers, and the type of that room.*/
select Hotel.Name, Room.Room_No, Room.Hotel_Type from Hotel join Room on Hotel.Hotel_No=Room.Hotel_No;

/*List the hotel names, booking dates, and room numbers for all hotels in New York.*/
select hotel.name,booking.date_from,booking.date_to,booking.room_no 
from hotel join booking on hotel.hotel_no=booking.hotel_no where city='New York';

/*What is the number of bookings that started in the month of September?*/
select count(*) from booking where date_from like '%SEP%';

/*List the names and cities of guests who began a stay in New York in August.*/
select Guest.Name,Guest.City from Guest join Booking on Guest.Guest_No=Booking.Guest_No where Booking.date_from like '%AUG%';

 /* List the hotel names and room numbers of any hotel rooms that have not been booked */ 
 select hotel.name,room.room_no from room join hotel on hotel.hotel_no=room.hotel_no where room_no not in (select room_no from booking); 
  
 /* List the hotel name and city of the hotel with the highest priced room */
 select hotel.name,hotel.city from hotel join room on hotel.hotel_no=room.hotel_no where price in (select max(price) from room);
 

/*  List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston hotel */ 
 	select name ,city ,room_no ,price from hotel join room on room.hotel_no=hotel.hotel_no where price < (select min(price) from room join hotel on hotel.hotel_no=room.hotel_no where city='Boston'); 
  

/*  List the average price of a room grouped by city */ 
 select city, avg(price) from room join hotel on hotel.hotel_no=room.hotel_no group by city;
 
