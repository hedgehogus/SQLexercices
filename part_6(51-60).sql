-- 51. Find the names of the ships with the largest number of guns among all ships having the same displacement (including ships in the Outcomes table).

WITH d1 AS 
(select name as NAME, displacement, numguns  
from ships inner join classes on ships.class = classes.class 
union 
select ship as NAME, displacement, numguns from outcomes inner join classes on outcomes.ship= classes.class),

d2 AS(
select displacement, max(numGuns) as numguns 
from ( 
select displacement, numguns 
from ships 
inner join classes on ships.class = classes.class  
union 
select displacement, numguns  from outcomes inner join classes on outcomes.ship= classes.class) as f 
group by displacement)

select NAME 
from d1 inner join d2
on d1.displacement=d2.displacement and d1.numguns =d2.numguns


-- 52. Determine the names of all ships in the Ships table that can be a Japanese battleship 
-- having at least nine main guns with a caliber of less than 19 inches and a displacement of not more than 65 000 tons.

SELECT name
FROM Classes JOIN Ships
ON Classes.class = Ships.class
WHERE (country = 'Japan' OR country IS NULL)
AND (numGuns >= 9 OR numGuns IS NULL)
AND (bore < 19 OR bore IS NULL)
AND (displacement <= 65000 OR displacement IS NULL)
AND (type = 'bb' OR type IS NULL)
UNION ALL
SELECT name
FROM Ships
WHERE class NOT IN
(SELECT Distinct Classes.class
FROM Classes JOIN Ships
ON Classes.class = Ships.class)

-- 53. With a precision of two decimal places, determine the average number of guns for the battleship classes.

SELECT CAST(AVG(numGuns * 1.0)AS NUMERIC(4,2))  AS AvgnumGuns
FROM Classes
WHERE type = 'bb'


