SET DATEFIRST 7;
SET LANGUAGE US_ENGLISH;

DECLARE @STARTDT DATE = '1950-01-01';
DECLARE @ENDDT DATE = '2050-12-31';

WITH DATE_CTE AS 
(
    SELECT @STARTDT AS DT
    UNION ALL
    SELECT DATEADD(DAY,1,DATE_CTE.DT) AS DT
    FROM DATE_CTE WHERE DT < @ENDDT
)
INSERT INTO [dbo].[date_tbl]
SELECT
    DT                          AS [date],
    DATEPART(YEAR,DT)           AS [year],
    DATEPART(QUARTER,DT)        AS [quarter],
    DATEPART(MONTH,DT)          AS [month],
    CASE 
        WHEN FLOOR(DATEDIFF(
            DAY,
            DATEADD(
                DAY,
                DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                    CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                    THEN 8 ELSE 1 END, -- OFFSET JAN 1 TO NEAREST DAY 1 ISO WEEK 1
                DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)), -- NEAREST DAY 1 ISO WEEK 1 TO JAN 1
            DT) / 7.0) + 1 = 0 -- WHEN ISO WEEK = 0
        THEN
            CASE 
            WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) <= 4
            THEN 1
            WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) = 5
            THEN 53
            ELSE 52
            END
        ELSE
            FLOOR(DATEDIFF(
            DAY,
            DATEADD(
                DAY,
                DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                    CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                    THEN 8 ELSE 1 END,
                DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)),
            DT) / 7.0) + 1
        END
                                AS [sun_ISO_week],
    CASE 
        WHEN
            CASE 
                WHEN FLOOR(DATEDIFF(
                    DAY,
                    DATEADD(
                        DAY,
                        DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                            CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                            THEN 8 ELSE 1 END, -- OFFSET JAN 1 TO NEAREST DAY 1 ISO WEEK 1
                        DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)), -- NEAREST DAY 1 ISO WEEK 1 TO JAN 1
                    DT) / 7.0) + 1 = 0 -- WHEN ISO WEEK = 0
                THEN
                    CASE 
                    WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) <= 4
                    THEN 1
                    WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) = 5
                    THEN 53
                    ELSE 52
                    END
                ELSE
                    FLOOR(DATEDIFF(
                    DAY,
                    DATEADD(
                        DAY,
                        DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                            CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                            THEN 8 ELSE 1 END,
                        DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)),
                    DT) / 7.0) + 1
                END --SUNDAY ISO WEEK
             > 50 AND MONTH(DT) = 1 THEN YEAR(DT) - 1
        WHEN 
            CASE 
                WHEN FLOOR(DATEDIFF(
                    DAY,
                    DATEADD(
                        DAY,
                        DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                            CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                            THEN 8 ELSE 1 END, -- OFFSET JAN 1 TO NEAREST DAY 1 ISO WEEK 1
                        DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)), -- NEAREST DAY 1 ISO WEEK 1 TO JAN 1
                    DT) / 7.0) + 1 = 0 -- WHEN ISO WEEK = 0
                THEN
                    CASE 
                    WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) <= 4
                    THEN 1
                    WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) = 5
                    THEN 53
                    ELSE 52
                    END
                ELSE
                    FLOOR(DATEDIFF(
                    DAY,
                    DATEADD(
                        DAY,
                        DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0))*-1 +
                            CASE WHEN DATEPART(WEEKDAY,DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)) > 4
                            THEN 8 ELSE 1 END,
                        DATEADD(YEAR, DATEDIFF(YEAR,0,DT),0)),
                    DT) / 7.0) + 1
                END --SUNDAY ISO WEEK
             = 1 AND MONTH(DT) = 12 THEN YEAR(DT) + 1
        ELSE YEAR(DT) END                     AS [sun_ISO_year],
    DATEPART(ISO_WEEK,DT)       AS [mon_ISO_week],
    CASE 
        WHEN DATEPART(ISO_WEEK,DT) > 50 AND MONTH(DT) = 1 THEN YEAR(DT) - 1
        WHEN DATEPART(ISO_WEEK,DT) = 1 AND MONTH(DT) = 12 THEN YEAR(DT) + 1
        ELSE YEAR(DT) END       AS [mon_ISO_year],
    DATEPART(WEEK,DT)           AS [week],
    DATEPART(DAYOFYEAR,DT)      AS [day_of_year],
    DATEPART(DAY,DT)            AS [day_of_month],
    DATEPART(WEEKDAY,DT)        AS [day_of_week],
    (DATEPART(DAY,DT)/8) + 1    AS [weekday_occurance],
    DATENAME(MONTH,DT)          AS [month_name],
    DATENAME(WEEKDAY,DT)        AS [weekday_name],
    CASE
        WHEN (MONTH(DT) = 1 AND DATEPART(DAY,DT) = 1) 
            THEN 'New Year''s Day'
        WHEN ((DATEPART(DAY,DT)/8) + 1 = 3 
        AND MONTH(DT) = 1 
        AND DATEPART(WEEKDAY,DT) = 2)
            THEN 'Martin Luther King Day'   -- (3rd Monday in January)
        WHEN ((DATEPART(DAY,DT)/8) + 1 = 3 
        AND MONTH(DT) = 2 AND DATEPART(WEEKDAY,DT) = 2)
            THEN 'President''s Day'         -- (3rd Monday in February)
        WHEN (ROW_NUMBER() OVER (PARTITION BY MONTH(DT), DATEPART(WEEKDAY,DT) ORDER BY DT DESC) = 1 --MONTH MUST BE COMPLETE TO BE ACCURATE
        AND MONTH(DT) = 4 AND DATEPART(WEEKDAY,DT) = 2)
            THEN 'Memorial Day'             -- (last Monday in May)
        WHEN (MONTH(DT) = 7 AND DATEPART(DAY,DT) = 4)
            THEN 'Independence Day'         -- (July 4th)
        WHEN ((DATEPART(DAY,DT)/8) + 1 = 1 
        AND MONTH(DT) = 9 AND DATEPART(WEEKDAY,DT) = 2)
            THEN 'Labor Day'                -- (first Monday in September)
        WHEN ((DATEPART(DAY,DT)/8) + 1 = 2 
        AND MONTH(DT) = 10 AND DATEPART(WEEKDAY,DT) = 2)
            THEN 'Columbus Day'             -- Columbus Day (second Monday in October)
        WHEN (MONTH(DT) = 11 AND DATEPART(DAY,DT) = 11)
            THEN 'Veterans'' Day'           -- Veterans' Day (November 11th)
        WHEN ((DATEPART(DAY,DT)/8) + 1 = 4 
        AND MONTH(DT) = 11 AND DATEPART(WEEKDAY,DT) = 5)
            THEN 'Thanksgiving Day'         -- Thanksgiving Day (fourth Thursday in November)
        WHEN (MONTH(DT) = 12 AND DATEPART(DAY,DT) = 25)
            THEN 'Christmas Day'
        ELSE '' END             AS [ntnl_holiday]
FROM DATE_CTE
ORDER BY DT ASC
OPTION (MAXRECURSION 0)

-- Ideas from the following resources:
-- https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/
-- http://biinsight.com/creating-a-simple-date-dimension-using-recursive-cte/

-- Thought process and tips for use:
-- The table is built for analytical purposes and is not intended as a substitute for SQL functions unless performance is found to be better.
-- Joining on date tables fills gaps in a time series.
-- Only the basic building blocks are included.  Many variants can be derived from these building blocks, or by using simple SQL functions.
-- Sample to convert dates to strings
--      https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017
--      CONVERT(VARCHAR(50) [date], 101) --01/01/2018
--      https://docs.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-2017
--      FORMAT([date],'d','en_US') --1/1/2018
--      FORMAT([date],'D','en_US') --Monday, January 01, 2018
--      https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-date-and-time-format-strings
--      FORMAT([date],'M','en_US') --January 01
--      FORMAT([date],'Y','en_US') --January, 2018
--      https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings
--      FORMAT([date],'MMM d, yyyy', 'en_US') --Jan 1, 2018