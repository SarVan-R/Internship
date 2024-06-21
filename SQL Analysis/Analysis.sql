select * from corona_data.regionwise;

SELECT * FROM corona_data.regionwise
WHERE Province IS NULL OR Region IS NULL OR Date IS NULL
	OR Latitude IS NULL OR Longitude IS NULL OR Date IS NULL
	OR Confirmed IS NULL OR Deaths IS NULL OR Recovered IS NULL;

UPDATE corona_data.regionwise
SET	Province = ifnull(Province,0),
	Region = ifnull(Region,0),
    Date = ifnull(Date,0),
	Latitude = ifnull(Latitude,0),
    Longitude = ifnull(Longitude,0);

#Question 3: check total number of rows
select count(*) from corona_data.regionwise;

#Question 4: Check what is start_date and end_date
SELECT MIN(str_to_date(Date,'%d-%m-%y')) AS Start_Date,
MAX(str_to_date(Date,'%d-%m-%y')) AS End_Date from corona_data.regionwise;

#Question 5: Number of month present in dataset
SELECT COUNT(DISTINCT(MONTH((str_to_date(Date,'%d-%m-%y'))))) AS MONTH
FROM corona_data.regionwise;

#Question 6: Find monthly average for confirmed, deaths, recovered
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month, AVG(Confirmed) 'Avg Confirmed',AVG(Deaths) 'Avg Deaths',AVG(Recovered) 'Avg Recovered'
FROM corona_data.regionwise
GROUP BY Month;

#Question 7: Find most frequent value for confirmed, deaths, recovered each month 
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month,
	MAX(Confirmed) AS Most_Freq_Confirmed,
    MAX(Deaths) AS Most_Freq_Deaths,
    MAX(Recovered) AS Most_Freq_Recovered
FROM corona_data.regionwise
GROUP BY Month; 

#Question 8: Find minimum values for confirmed, deaths, recovered per year
select year(str_to_date(Date,'%d-%m-%y')) AS Year,
	MIN(Confirmed) AS MIN_Confirmed,
    MIN(Deaths) AS MIN_Deaths,
    MIN(Recovered) AS MIN_Recovered
FROM corona_data.regionwise
GROUP BY Year; 

#Question 9: Find maximum values of confirmed, deaths, recovered per year
SELECT YEAR(str_to_date(Date,'%d-%m-%y')) AS Year,
	MAX(Confirmed) AS MAX_Confirmed,
    MAX(Deaths) AS MAX_Deaths,
    MAX(Recovered) AS MAX_Recovered
FROM corona_data.regionwise
GROUP BY Year;

#Question 10: The total number of case of confirmed, deaths, recovered each month
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month,
	sum(Confirmed) AS No_Confirmed_Case,
    sum(Deaths) AS No_Deaths_Case,
    sum(Recovered) AS No_Recovered_Case
FROM corona_data.regionwise
GROUP BY Month;

#Question 11: Check how corona virus spread out with respect to confirmed case
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month,
SUM(Confirmed) 'Total Confirmed Case',
ROUND(AVG(Confirmed),2) 'Average Confirmed Case',
ROUND(VARIANCE(Confirmed),2) 'Variance confirmed',
ROUND(STDDEV(Confirmed),2) 'Stfdev_confirmed'
FROM corona_data.regionwise
GROUP BY Month;
  
#Question 12: Check how corona virus spread out with respect to death case per month
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month,
SUM(Deaths) 'Total Death Case',
ROUND(AVG(Deaths),2) 'Average Death Case',
ROUND(VARIANCE(Deaths),2) 'Variance Death',
ROUND(STDDEV(Deaths),2) 'Stfdev_Death'
FROM corona_data.regionwise
GROUP BY Month;

#Question 13: Check how corona virus spread out with respect to recovered case
SELECT month(str_to_date(Date,'%d-%m-%y')) AS Month,
SUM(Recovered) 'Total Recovered Case',
ROUND(AVG(Recovered),2) 'Average Recovered Case',
ROUND(VARIANCE(Recovered),2) 'Variance Recovered',
ROUND(STDDEV(Recovered),2) 'Stfdev_recovered'
FROM corona_data.regionwise
GROUP BY Month;

#Question 14: Find Country having highest number of the Confirmed case
SELECT Region, sum(Confirmed) AS HIGH_CASE
FROM corona_data.regionwise
GROUP BY Region
ORDER BY HIGH_CASE DESC
LIMIT 1;

#Question 15: Find Country having lowest number of the death case
SELECT Region, sum(Deaths) AS LOW_DEATHS
FROM corona_data.regionwise
GROUP BY Region
ORDER BY LOW_DEATHS ASC
LIMIT 1;

#Question 16: Find top 5 countries having highest recovered case
SELECT Region, sum(Recovered) AS HIGH_Recovered
FROM corona_data.regionwise
GROUP BY Region
ORDER BY HIGH_Recovered DESC
LIMIT 5;