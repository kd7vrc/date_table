IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'date_tbl')
DROP TABLE [dbo].[date_tbl];

CREATE TABLE [dbo].[date_tbl]
(
    [date]              DATE        NOT NULL,
    CONSTRAINT [PK_date_tbl] PRIMARY KEY NONCLUSTERED ([date]),
    [year]              INT         NOT NULL,
    [quarter]           TINYINT     NOT NULL,
    [month]             TINYINT     NOT NULL,
    [sun_ISO_week]      TINYINT     NOT NULL,
    [sun_ISO_year]      INT         NOT NULL,
    [mon_ISO_week]      TINYINT     NOT NULL,
    [mon_ISO_year]      INT         NOT NULL,
    [week]              TINYINT     NOT NULL,
    [day_of_year]       INT         NOT NULL,
    [day_of_month]      TINYINT     NOT NULL,
    [day_of_week]       TINYINT     NOT NULL,
    [weekday_occurance] TINYINT     NOT NULL,
    [month_name]        VARCHAR(10) NOT NULL,
    [weekday_name]      VARCHAR(10) NOT NULL,
    [ntnl_holiday]     VARCHAR(64) NOT NULL
);
CREATE CLUSTERED COLUMNSTORE INDEX [IX_date_tbl] ON [dbo].[date_tbl];

GRANT SELECT ON [dbo].[date_tbl] TO [InternalReport]
GRANT VIEW DEFINITION ON [dbo].[date_tbl] TO [InternalReport]
GO

EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value='Basic date table for analytical use.  Not intended as an encyclopedia of all date variants and facts.
	Date formatting resources:
    https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017
    https://docs.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-2017
    https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-date-and-time-format-strings
    https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings
    https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-2017',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Regular SQL Date',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'date'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'A.D. Year YEAR([date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'year'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Quarter number of the year DATEPART(QUARTER,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'quarter'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Gregorian month number of the year MONTH([date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'month'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'ISO week number starting Sunday.',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'sun_ISO_week'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'ISO year for ISO week number starting Sunday.',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'sun_ISO_year'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'ISO week number starting Monday. DATEPART(ISO_WEEK,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'mon_ISO_week'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'ISO year for ISO week number starting Monday.',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'mon_ISO_year'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Traditional week number weeks starting Sunday numbered from Jan 1 with partial weeks around the new year. DATEPART(WEEK,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'week'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Day of year or number of days since December 31 of the preceeding year. DATEPART(DAYOFYEAR,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'day_of_year'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Day number in the month. DATEPART(DAY,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'day_of_month'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'Day number of the week starting Sunday DATEPART(WEEKDAY,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'day_of_week'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'The occurance of the weekday in the month. For example a value of 2 might represent the second Thursday in the month.',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'weekday_occurance'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'English name of the Gregorian month. DATENAME(MONTH,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'month_name'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'English name of the Gregorian day of the week. DATENAME(WEEKDAY,[date])',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'weekday_name'
EXEC sys.sp_addextendedproperty 
    @name=N'MS_Description',    @value=N'U.S. National Holidays as defined on https://www.officeholidays.com/countries/usa/index.php as of Aug 2018',
    @level0type=N'SCHEMA',      @level0name=N'dbo',
    @level1type=N'TABLE',       @level1name=N'date_tbl',
    @level2type=N'COLUMN',      @level2name=N'ntnl_holiday'