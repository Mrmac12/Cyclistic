
CREATE TABLE [dbo].[BikeData2023](
	[ride_id] [nvarchar](50) NOT NULL,
	[rideable_type] [nvarchar](50) NOT NULL,
	[start_time] [datetime2](7) NOT NULL,
	[end_time] [datetime2](7) NOT NULL,
	[start_station_name] [nvarchar](100) NULL,
	[start_station_id] [nvarchar](100) NULL,
	[end_station_name] [nvarchar](100) NULL,
	[end_station_id] [nvarchar](100) NULL,
	[start_lat] [float] NULL,
	[start_long] [float] NULL,
	[end_lat] [float] NULL,
	[end_long] [float] NULL,
	[member_casual] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_2023_BikeData] PRIMARY KEY CLUSTERED 
(
	[ride_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
*/

/*Data from each table was inserted into the newly created table a total of 5,719,877 rows*/

Insert into BikeData2023
SELECT 
*
FROM BikeDataJan2023
UNION ALL
SELECT 
*
FROM BikeDataFeb2023
UNION ALL
SELECT 
*
FROM BikeDataMar2023
UNION ALL
SELECT 
*
FROM BikeDataApr2023
UNION ALL
SELECT 
*
FROM BikeDataMay2023
UNION ALL
SELECT 
*
FROM BikeDataJun2023
UNION ALL
SELECT 
*
FROM BikeDataJul2023
UNION ALL
SELECT 
*
FROM BikeDataAug2023
UNION ALL
SELECT 
*
FROM BikeDataSep2023
UNION ALL
SELECT 
*
FROM BikeDataOct2023
UNION ALL
SELECT 
*
FROM BikeDataNov2023
UNION ALL
SELECT 
*
FROM BikeDataDec2023
