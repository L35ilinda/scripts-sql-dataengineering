IF OBJECT_ID(N'tempdb..##TransactionDateRange') IS NOT NULL
    DROP TABLE ##TransactionDateRange;

CREATE TABLE ##TransactionDateRange(
			StartDate varchar (10),
			EndDate	varchar (10)
);

--Historical Loads using specific date ranges
DECLARE @EndDate date = (SELECT CAST (? AS DATE));
DECLARE @Interval int = ?
DECLARE @StartDate  date = (SELECT DATEADD(day,(-@Interval + 1),@EndDate));
DECLARE @FirstDate  date = (SELECT (CAST (? AS DATE)))

-- Delta Loads using dynamic dates
/*
DECLARE @EndDate date = (SELECT CAST (GETDATE() AS DATE));
DECLARE @Interval int = ?
DECLARE @StartDate  date = (SELECT DATEADD(day,(-@Interval + 1),@EndDate));
DECLARE @FirstDate  date = (SELECT DATEADD(day, -15,(CAST (GETDATE() AS DATE))))
*/


WHILE (@EndDate >= @FirstDate) 

BEGIN

INSERT INTO ##TransactionDateRange
SELECT	CAST(@StartDate AS VARCHAR)	as StartDate
		, CAST(@EndDate AS VARCHAR) as EndDate;

set @StartDate = DATEADD(day, -@Interval, @StartDate)
set @EndDate = DATEADD(day, -@Interval, @EndDate);

END;

SELECT *
FROM ##TransactionDateRange
