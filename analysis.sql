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

[PM2#5 AQI Value],
CASE 
when [PM2#5 AQI Value] <= 50 then 'Good'
when [PM2#5 AQI Value] between 51 and 99 then 'Moderate'
when [PM2#5 AQI Value] between 100 and 149 then 'Unhealthy for Sensitive Groups'
when [PM2#5 AQI Value] between 150 and 200 then 'Unhealty'
when [PM2#5 AQI Value] between 201 and 299 then 'Very Unhealty'
when [PM2#5 AQI Value] >= 300 then 'Hazardous' end as 'PM2#5 AQI Category'
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



















