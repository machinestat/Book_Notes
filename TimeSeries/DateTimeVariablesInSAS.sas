LIBNAME sasts "C:\Books\SAS\Practical Time Series Analysis";
/*Inclusion of a format in a procedure call*/
PROC PRINT DATA = sasts.hotel;
    VAR date;
    FORMAT date monyy5.;
RUN;

/*Date format mmddyy10. represents the date in an American English way, and mmddyy6. removes the slashes and*/
/*the first two digits for the year.*/
/*Includsion of a detailed format in a procedure call*/
PROC PRINT DATA = sasts.arctic_ice_daily;
    VAR date;
    FORMAT date mmddyy6.;
RUN;

/*Use OPTIONS DFLLANG = to change the formats for presenting dates in styles other than American English*/

/*The time part alone could be written by the format tod12., which abbreviates Time Of Day. Information for both*/
/*the date and the time of day in hours, minutes, and seconds could be written by the format datetime20.*/
/*An application of various datetime formats*/
DATA speed1;
    SET sasts.speed(OBS = 10);
    d1 = dt;
    d2 = dt;
    d3 = dt;
RUN;
PROC PRINT DATA = speed1 NOOBS;
    VAR d1-d3;
    FORMAT d1 tod12.; /* show time without date*/
    FORMAT d2 datetime20.;
RUN;

/*Formats also allow for specifications of the time, including decimal fractions of seconds*/
/*Printing using both a time format and a date format*/
PROC PRINT DATA = sasts.baby (FIRSTOBS = 12345 OBS = 12349) NOOBS;
    VAR time;
    FORMAT time TOD12.3;
RUN;
PROC PRINT DATA = sasts.baby (FIRSTOBS = 12345 OBS = 12349) NOOBS;
    VAR time;
    FORMAT time datetime 12.3;
RUN;

/*Import Datetime Variables*/
/*When data is imported from software products other than SAS by using the various import engines in SAS,*/
/*most datetime variables are recognized and converted to proper SAS datetime variables with convenient formats.*/
/*Teh reading of date variables is technically done by the informat ANYDTDTE,which tries to convert the actual*/
/*text and numbers into dates in a meaningful way.*/
/*Input of a date variable using an automatic input format*/
DATA d3;
    INPUT date1 anydtdte20.;
    FORMAT date1 date10.;
DATALINES;
12022005
122005
dec05
;
RUN;
PROC PRINT DATA = d3;
RUN;

/*The name ANYDTDTE is short for ANY DateTime DaTE because it extracts the date part of the import even if time*/
/*information is also given. Similarly, the ANYDTDTM(ANYDateTime DateTiMe) informat extracts the datetime part,*/
/*and the ANYDTTME (ANY DateTime TiME) informat extracts only the time part and neglects the date.*/
/*Input of a datetime variable using a flexible input format*/
DATA s1;
    INPUT dt ANYDTDTM25.;
    FORMAT dt datetime16.10;
DATALINES;
06-06-02:15:25:51
06/06/02/15/25/54
11-06-02,15:25:57
06.11.02,15.25.59
06062002.15.25.59
;
RUN;
PROC PRINT DATA = s1;
RUN;

/*Handling Datetime Variables*/
/*If the variable date represents dates, then the day, the month, the quarter, and the year are extracted by the*/
/*functions day, month, qtr, and year. Hours, minutes, and seconds could be extracted by SAS functions with */
/*obvious names. The date of a datetime variable is extracted by the function datepart.*/
/*Example: Plotting quarterly data by year*/
DATA a;
    SET sasts.e_commerce;
    yy = year(date);
    q = qtr(date);
RUN;
PROC SGPLOT DATA = a;
    SERIES x = q y = e_commerce/MARKERS GROUP = yy;
    XAXIS VALUES = (1 to 4 by 1);
    WHERE yy < 2010 AND yy > 2005;
RUN;
QUIT;
/*Extracting of the day, the month, and the year from a date variable using SAS functions*/
DATA a;
    SET sasts.copy_machine;
    day_part = DAY(date);
    month_part = MONTH(date);
    year_part = YEAR(date);
RUN;
PROC PRINT DATA = a;
RUN;

/*Time Series Data Sets*/
/*Transforming a time series using differences and lags*/
DATA changes;
    SET sasts.uk_unemployment;
    monthly_change = DIF(unemployment);
    yearly_change = DIF12(unemployment);
    previous_month = lag(unemployment);
    previous_year = lag(unemployment);
RUN;
PROC PRINT DATA = changes (OBS = 20);
RUN;
