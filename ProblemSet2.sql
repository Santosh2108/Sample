Create table Location (locationid number primary key, name varchar2(30), sunlight number, water number); 
Create table Gardener (gardenerid number primary key, name varchar2(30), age number); 
Create table Plant (plantid number primary key, name varchar2(30), sunlight number, water number, weight number); 
Create table planted (plantFK number, gardenerFK number, locationFK number, date1 date, seeds number, foreign key(plantFK) references plant(plantid), foreign key(gardenerFK) references gardener(gardenerid), foreign key(locationFK) references location(locationid)); 
Create table picked (plantFK number, gardenerFK number, locationFK number, date1 date, amount number, weight number, foreign key(plantFK) references plant(plantid), foreign key(gardenerFK) references gardener(gardenerid), foreign key(locationFK) references location(locationid));  

Insert into location values(0, 'East', .28, .80); 
Insert into location values(1, 'North', .17, .84); 
Insert into location values(2, 'West', .38, .48); 
Insert into location values(3, 'South', .45, .66); 
Insert into gardener values(0, 'Mother', 36); 
Insert into gardener values(1, 'Father', 38); 
Insert into gardener values(2, 'Tim', 15); 
Insert into gardener values(3, 'Erin', 12); 

Insert into plant values(0, 'Carrot', .26, .82, .08); 
Insert into plant values(1, 'Beet', .44, .80, .04); 
Insert into plant values(2, 'Corn', .44, .76, .26); 
Insert into plant values(3, 'Tomato', .42, .80, .16); 
Insert into plant values(4, 'Radish', .28, .84, .02); 
Insert into plant values(5, 'Lettuce', .29, .85, .03); 

Insert into planted values(0, 0, 0 , '18-APR-2012', 28); 
Insert into planted values(0, 1, 1 , '14-APR-2012', 14); 
Insert into planted values(1, 0, 2 , '18-APR-2012', 36); 
Insert into planted values(2, 1, 3 , '14-APR-2012', 20); 
Insert into planted values(2, 2, 2 , '19-APR-2012', 12); 
Insert into planted values(3, 3, 3 , '25-APR-2012', 38); 
Insert into planted values(4, 2, 0 , '30-APR-2012', 30); 
Insert into planted values(5, 2, 0 , '15-APR-2012', 30); 

Insert into picked values(0, 2, 0 , '18-AUG-2012', 28, 2.32); 
Insert into picked values(0, 3, 1 , '16-AUG-2012', 12, 1.02); 
Insert into picked values(2, 1, 3 , '22-AUG-2012', 52, 12.96); 
Insert into picked values(2, 2, 2 , '28-AUG-2012', 18, 4.58); 
Insert into picked values(3, 3, 3 , '22-AUG-2012', 15, 3.84); 
Insert into picked values(4, 2, 0 , '16-JUL-2012', 23, 0.52); 






/*Write a valid SQL statement that calculates the total weight of all corn cobs that were picked from the garden*/
select sum(picked.weight) from picked join plant on picked.plantfk=plant.plantid 
where plant.name='Corn';

/*For some reason Erin has change his location for picking the tomato to North. Write the corresponding query.*/
update picked set locationfk=1 where plantfk=3;

/*Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores Experience of the of person. How will you modify this to varchar2(30).*/
alter table picked add Exper Number (30);
alter table picked modify Exper varchar2(30);

/*Write a query to find the plant name which required seeds less than 20 which plant on 14-APR*/
select plant.name from plant join planted on plant.plantid=planted.plantfk
where planted.seeds<20 and planted.date1 like '14-AUG%';


/*List the amount of sunlight and water to all plants with names that start with letter 'c' or letter 'r'.*/
select name,sunlight,water from Plant where name like 'c%' or name like 'r%';

/*Write a valid SQL statement that displays the plant name and the total amount of seed required for each plant that were plant in the garden. The output should be in descending order of plant name.*/
select plant.name, sum(planted.seeds) as Total from plant join planted
on plant.plantid=planted.plantfk group by plant.name order by Total;

/*Write a valid SQL statement that calculates the average number of items produced per seed planted for each plant type:( (Average Number of Items = Total Amount Picked / Total Seeds Planted.)*/
SELECT Plant.Name, AVG(Picked.Amount/Planted.Seeds) AS yield FROM Plant, Planted, Picked 
WHERE Planted.PlantFK = Picked.PlantFK AND Planted.LocationFK = Picked.LocationFK
AND Plant.PlantID=Picked.PlantFK GROUP BY Plant.Name

/*Write a valid SQL statement that would produce a result set like the following:
 name |  name  |    date    | amount 
------|--------|------------|-------- 
 Tim  | Radish | 2012-07-16 |     23 
 Tim  | Carrot | 2012-08-18 |     28 */
SELECT Gardener.Name, Plant.Name, Date, Amount FROM Picked, Gardener, Plant 
WHERE Plant.PlantId = Picked.PlantFK AND Gardener.GardenerId = Picked.GardenerFK 
AND Picked.GardenerFK = 2 ORDER BY Date

/* Find out persons who picked from the same location as he/she planted.  */
select distinct(name) from gardener g  join planted pl on g.gardenerid=pl.gardenerfk inner join picked pi on g.gardenerid=pi.gardenerfk 
	where pi.locationfk=pl.locationfk; 

/* Create a view that lists all the plant names picked from all locations except ’West’ in the month of August. */
 create view plant_list as select name from plant where name not in (select pl.name from picked p join plant pl on pl.plantid=p.plantFK where locationFK=2 and substr(date1,4,3)!='AUG');
