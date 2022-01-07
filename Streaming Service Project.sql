Select *
From [Streaming Service Project]..DisneyStreamingData

----------------------------------------------------------------------------------

--Breaking apart list of countries into individual columns


Select country
From [Streaming Service Project]..DisneyStreamingData


Select
 PARSENAME(REPLACE(country, ',', '.') , 2)
 ,PARSENAME(REPLACE(country, ',', '.') , 1)
From [Streaming Service Project]..DisneyStreamingData


ALTER TABLE DisneyStreamingData
Add country1 Nvarchar(255);

Update DisneyStreamingData
SET country1 = PARSENAME(REPLACE(country, ',', '.') , 2)



ALTER TABLE DisneyStreamingData
Add country2 Nvarchar(255);

Update DisneyStreamingData
SET country2 = PARSENAME(REPLACE(country, ',', '.') , 1)


Select *
From [Streaming Service Project]..DisneyStreamingData


----------------------------------------------------------------------------------

--Change NULL to blanks for country1 column

Select country1
, CASE When country1 is NULL Then ' ' 
       ELSE country1
       END
From [Streaming Service Project]..DisneyStreamingData


Update DisneyStreamingData
SET country1 = CASE When country1 is NULL Then ' '
	   ELSE country1
	   END


----------------------------------------------------------------------------------

--Combining columns and tables


Update DisneyStreamingData
Set country1 = country2
Where country1 = ' '

Insert into DisneyStreamingData
(show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, country1)
Select * 
From DisneyStreamingData2


Select *
From [Streaming Service Project]..DisneyStreamingData
Order by title

-----------------------------------------------------------------------------------

--Deleting Unused Columns 

Alter Table DisneyStreamingData 
Drop Column country2

------------------------------------------------------------------------------------

--Removing Duplicates

WITH RowNumCTE AS(
Select *, 
ROW_NUMBER() OVER (
	PARTITION BY show_id,
				 type,
				 title,
				 director,
				 cast,
				 country,
				 date_added,
				 release_year,
				 rating,
				 duration,
				 listed_in,
				 description,
				 country1
				 Order By
					show_id
					) row_num

From [Streaming Service Project]..DisneyStreamingData

)
Delete
From RowNumCTE
Where row_num > 1



Select *
From [Streaming Service Project]..DisneyStreamingData
Order by title

------------------------------------------------------------------------------------

--Standardize Date format

Select date_addedConverted, CONVERT(Date, date_added)
From [Streaming Service Project]..DisneyStreamingData

Update DisneyStreamingData
SET date_added = CONVERT(Date,date_added)


ALTER TABLE DisneyStreamingData
Add date_addedConverted Date;

Update DisneyStreamingData
SET date_addedConverted = CONVERT(Date,date_added)

------------------------------------------------------------------------------------


--Select data that will be used 

Select type, title, country1, date_addedConverted, release_year, rating, duration, listed_in
From [Streaming Service Project]..DisneyStreamingData
Order by 1,2

--Movies & TV Shows in the United States

Select type, title, country1
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'United States'
--Where type = 'Movie' and country1 = 'United States'
--Where type = 'TV Show' and country1 = 'United States'
Order by 1,2


Select type, title, country1, listed_in
From [Streaming Service Project]..DisneyStreamingData
Where listed_in like '%Comedy%' and country1 = 'United States'
Order by 1,2


--Movies & TV Shows in Canada

Select type, title, country1
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'Canada'
--Where type = 'Movie' and country1 = 'Canada'
--Where type = 'TV Show' and country1 = 'Canada'
Order by 1,2

Select type, title, country1, listed_in
From [Streaming Service Project]..DisneyStreamingData
Where listed_in like '%Family%' and country1 = 'Canada'
Order by 1,2


--Movies & TV Shows in the United Kingdom

Select type, title, country1
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'United Kingdom'
--Where type = 'Movie' and country1 = 'United Kingdom'
--Where type = 'TV Show' and country1 = 'United Kingdom'
Order by 1,2

Select type, title, country1, listed_in
From [Streaming Service Project]..DisneyStreamingData
Where listed_in like '%Animation%' and country1 = 'United Kingdom'
Order by 1,2


Select type, title, country1
From [Streaming Service Project]..DisneyStreamingData
Where country1 <> 'United Kingdom'
And country1 <> 'United States'
And country1 <> 'Canada'
Order by 1,2


--Release Year dates & dates added to streaming service

Select *
From [Streaming Service Project]..DisneyStreamingData
Where release_year = 2021
And date_addedConverted > '2021-10-01'
Order by 2,3


--Movie and TV Show Ratings

Select type, title, country1, release_year, rating
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'United States'
And rating = 'G'
Order by 1,2

Select type, title, country1, release_year, rating
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'Canada'
And rating = 'PG-13'
Order by 1,2

Select type, title, country1, release_year, rating
From [Streaming Service Project]..DisneyStreamingData
Where country1 = 'United Kingdom'
And rating = 'TV-PG'
Order by 1,2

Select type, title, country1, release_year, rating
From [Streaming Service Project]..DisneyStreamingData
Where country1 <> 'United Kingdom'
And country1 <> 'Canada'
And country1 <> 'United States'
And rating = 'PG-13'
Order by 1,2


--Movie & TV Show Durations

Select type, title, country1, release_year, duration
From [Streaming Service Project]..DisneyStreamingData
Where type = 'Movie'
Order by duration 


Select type, title, country1, release_year, duration
From [Streaming Service Project]..DisneyStreamingData
Where type = 'TV Show'
Order by duration DESC


--Select *
--From [Streaming Service Project]..DisneyStreamingData
--Order by 2,3