---------------------------------------------------------------------------------CLEAN---------------------------------------------------------------------------------

-- We have some null values in Country and City columns.
delete from airs
where Country is null or City is null

------------------------------------------------------------------------------ANALYSIS---------------------------------------------------------------------------------

-- All cities have 5 or 6 values. This will be a problem in future. Therefore we need to get average this values.

with air as (
select
Country,
City,
[AQI Value],
CASE 
when [AQI Value] <= 50 then 'Good'
when [AQI Value] between 51 and 99 then 'Moderate'
when [AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [AQI Value] between 150 and 200 then 'Unhealty'
when [AQI Value] between 201 and 299 then 'Very Unhealty'
when [AQI Value] >= 300 then 'Hazardous' end as 'AQI Category',

[CO AQI Value],
CASE 
when [CO AQI Value] <= 50 then 'Good'
when [CO AQI Value] between 51 and 99 then 'Moderate'
when [CO AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [CO AQI Value] between 150 and 200 then 'Unhealty'
when [CO AQI Value] between 201 and 299 then 'Very Unhealty'
when [CO AQI Value] >= 300 then 'Hazardous' end as 'CO AQI Category',

[Ozone AQI Value],
CASE 
when [Ozone AQI Value] <= 50 then 'Good'
when [Ozone AQI Value] between 51 and 99 then 'Moderate'
when [Ozone AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [Ozone AQI Value] between 150 and 200 then 'Unhealty'
when [Ozone AQI Value] between 201 and 299 then 'Very Unhealty'
when [Ozone AQI Value] >= 300 then 'Hazardous' end as 'Ozone AQI Category',

[NO2 AQI Value],
CASE 
when [NO2 AQI Value] <= 50 then 'Good'
when [NO2 AQI Value] between 51 and 99 then 'Moderate'
when [NO2 AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [NO2 AQI Value] between 150 and 200 then 'Unhealty'
when [NO2 AQI Value] between 201 and 299 then 'Very Unhealty'
when [NO2 AQI Value] >= 300 then 'Hazardous' end as 'NO2 AQI Category',

[PM2.5 AQI Value],
CASE 
when [PM2.5 AQI Value] <= 50 then 'Good'
when [PM2.5 AQI Value] between 51 and 99 then 'Moderate'
when [PM2.5 AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [PM2.5 AQI Value] between 150 and 200 then 'Unhealty'
when [PM2.5 AQI Value] between 201 and 299 then 'Very Unhealty'
when [PM2.5 AQI Value] >= 300 then 'Hazardous' end as 'PM2.5 AQI Category'
from
(select  
country,
city,
round(avg([AQI Value]), 0) as "AQI Value",
round(avg([CO AQI Value]), 0) as "CO AQI Value",
round(avg([Ozone AQI Value]), 0) as "Ozone AQI Value",
round(avg([NO2 AQI Value]), 0) as "NO2 AQI Value",
round(avg([PM2#5 AQI Value]), 0) as "PM2#5 AQI Value"
from airs
group by Country, City
)as den)

select * from air

-- I have a few questions for create a analysis.

-- 1. Which countries have the worst air quality? (This dataset has 4 different air quality scale about bad air quality.)
--Note: We have more than 5 countries about bad air qualities. You can find the other countries in data visualization section.

-- The first and worst is hazardous.
select 
Country,
count(*)
from air
where [AQI Category] = 'Hazardous'
group by Country
order by COUNT(*) desc
/*
India --> 94
Pakistan --> 12
Chile --> 1
USA --> 1
*/

-- The second is very unhealty records.
select 
Country,
count(*)
from air
where [AQI Category] = 'Very Unhealty'
group by Country
order by COUNT(*) desc
/*
India --> 433
Pakistan --> 49
Mexico --> 35
South Africa --> 15
Indonesia --> 12 
records about 'Very Unhealty' air quality.
*/

-- The other one is unhealty.
select 
Country,
count(*)
from air
where [AQI Category] = 'Unhealty'
group by Country
order by COUNT(*) desc
/*
India --> 732
China --> 301
Pakistan --> 204
Mexico --> 68
Indonesia --> 38 
records about 'Unhealty' air quality.
*/

-- The last one is unhealty for sensitive groups.
select 
Country,
count(*)
from air
where [AQI Category] = 'Unhealthy for Sensitive Groups'
group by Country
order by COUNT(*) desc
/*
India --> 558
China --> 254
Brazil --> 85
USA --> 81
Mexico --> 64
records about 'Unhealty for Sensitive Groups' air quality.
*/

















