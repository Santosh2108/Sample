create table Highschooler(ID int, name varchar2(30), grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);

insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101); 

/* 1.Find the names of all students who are friends with someone named Gabriel. */

select distinct name from Highschooler 
where ID in (select ID1 from Friend 
where ID2 in (select ID from Highschooler where name="Gabriel")); 


/* 2.For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. */
 
select distinct sName, sGrade, lName, lGrade 
from (select h1.name as sName, h1.grade sGrade, h2.name as lName, h2.grade as lGrade, h1.grade-h2.grade as gradeDiff  
from Highschooler h1, Likes, Highschooler h2 
where h1.ID=ID1 and h2.ID=ID2) 
where gradeDiff>1; 


/* 3.Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade. */

select name,grade from Highschooler 
where ID not in (select ID1 from Likes union select ID2 from Likes) 
order by grade, name; 


/* 4.For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. */

select distinct H1.name, H1.grade, H2.name, H2.grade 
from Highschooler H1, Likes, Highschooler H2 
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and H2.ID not in (select ID1 from Likes); 


/* 5.Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.*/

select name, grade from Highschooler 
where ID not in ( 
select ID1 from Highschooler H1, Friend, Highschooler H2 
where H1.ID = Friend.ID1 and Friend.ID2 = H2.ID and H1.grade <> H2.grade) 
order by grade, name; 


/* 6.Find the difference between the number of students in the school and the number of different first names. */

select st.sNum-nm.nNum from  
(select count(*) as sNum from Highschooler) as st, 
(select count(distinct name) as nNum from Highschooler) as nm; 


/* 7.Find the name and grade of all students who are liked by more than one other student. */

select name, grade  
from (select ID2, count(ID2) as numLiked from Likes group by ID2), Highschooler 
where numLiked>1 and ID2=ID; 


/* 8.For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C. */

select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade 
from Likes L1, Likes L2, Highschooler H1, Highschooler H2, Highschooler H3 
where L1.ID2 = L2.ID1 
and L2.ID2 <> L1.ID1 
and L1.ID1 = H1.ID and L1.ID2 = H2.ID and L2.ID2 = H3.ID;  


/* 9.What is the average number of friends per student? (Your result should be just one number.) */

select avg(count) 
from (select count(ID2) as count 
from Friend 
group by ID1) as FriendCount; 
              
              
              

