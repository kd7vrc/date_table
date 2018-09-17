# Date Table
Create and populate a date table for analytical use in a data warehouse.
## General Notes
Although SQL Server provides rich functionality for date and time manipulation, it is common and, at times, simpler to use a date table for analytical and business intelligence work.  Many columns might be added, and some might be considered unnecessary.  This implementation attempts to provide a balanced solution providing useful and essential elements without unnecessarily replacing simple T-SQL functions.
## ISO Weeks
Although ISO weeks are difficult to understand at first, they are useful in reporting year over year figures at the week level where all weeks must be complete.  Although SQL Server has an ISO_WEEK option in the DATEPART function, it lacks functionality for the associated ISO year.
### Code derived from examples at the following sites:
https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/
http://biinsight.com/creating-a-simple-date-dimension-using-recursive-cte/
