/*Date and Time Functions*/
/*Functions That Create SAS Date, Datetime, and Time Values*/
/*Function: MDY*/
/*Purpose: To create a SAS date from the month, day, and year.*/
/*Syntax: MDY(month, day, year) */
/*		month is a numeric variable or constant representing the month of theyear (a number from 1 to 12). */
/*		day is a numeric variable or constant representing the day of the month (a number from 1 to 31). */
/*		year is a numeric variable or constant representing the year. */
/*Program 4.1: Creating a SAS date value from separate variables representing the day, month, and year */
/*			of the date*/
DATA FunnyDate;
	INPUT @1  Month 2.
		  @7  Year 4.
		  @13 Day 2.;
	Date = MDY(Month, Day, Year);
	FORMAT Date mmddyy10.;
DATALINES;
05    2000  25
11    2001  02
;
RUN;
TITLE "Listing of FUNNYDATE";
PROC PRINT DATA = FunnyDate NOOBS;
RUN;

/*Program 4.2: Program to read in dates and set the day of the month to 15 if the day is missing from the date*/
DATA Missing;
	INPUT @1 Dummy $10.;
	Day = SCAN(Dummy, 2, '/');
	IF NOT MISSING(Day) THEN Date = INPUT(Dummy, mmddyy10.);
	ELSE Date = MDY(INPUT(SCAN(Dummy, 1, '/'), 2.), 
				15, 
				INPUT(SCAN(Dummy, 3, '/'), 4.));
	FORMAT Date date9.;
DATALINES;
10/21/1946
1/ /2000
01/ /2002
;
RUN;
TITLE "Listing of Missing";
PROC PRINT DATA = Missing NOOBS;
RUN;

/*Function: DHMS*/
/*Purpose: To create a SAS datetime value from a SAS date value and a value for the hour, minute, and second.*/
/*Syntax: DHMS(date, hour, minute, second)*/
/*		date is a SAS date value, either a variable or a date constant.*/
/*		hour is a numerical value for the hour of the day. If hour is greater than 24, the function will */
/*		return the appropriate datetime value.*/
/*		minute is a numerical value for the number of minutes.*/
/*		second is a numerical value for the number of seconds.*/
/*		Values of the date value that are invalid result in a missing value, and an error message is written */
/*		to the SAS log*/
/**/
/*Function: HMS*/
/*Purpose: To create a SAS time value from the hour, minute, and second.*/
/*Syntax: HMS(hour, minute, second)*/
/*		hour is the value corresponding to the number of hours.*/
/*		minute is the value corresponding to the number of minutes.*/
/*		second is the value corresponding to the number of seconds. */
/**/
/*Function: DATE and TODAY (equivalent functions)*/
/*Purpose: To return the current date.*/
/*Syntax: DATE() or TODAY()*/
/*		Note that the parentheses are needed even though these functions do not take any arguments.*/
/*		*/
/*Function: DATETIME*/
/*Purpose: To return the datetime value for the current date and time.*/
/*Syntax: DATETIME()*/
/**/
/*Function: TIME*/
/*Purpose: To return the time of day when the program was run.*/
/*Syntax: TIME()*/
/**/
/*Program 4.3: Determining the date, datetime value, and time of day */
DATA Test;
	Date = TODAY();
	DT = DATETIME();
	Time = TIME();
	DT2 = DHMS(Date, 8, 15, 30);
	Time2 = HMS(8, 15, 30);
	DOB = '01jan1960'd;
	Age = INT(YRDIF(DOB, Date, 'actual'));
	FORMAT Date DOB date9. DT DT2 datetime. 
		   Time Time2 time.;
RUN;
PROC PRINT DATA = Test NOOBS;
RUN;

/*Program 4.4: Program to create the DATES data set*/
DATA Dates;
	INFORMAT Date1 Date2 date9.;
	INPUT Date1 Date2;
	FORMAT Date1 Date2 date9.;
DATALINES;
01JAN1960 15JAN1960
02MAR1961 18FEB1962
25DEC2000 03JAN2001
01FEB2002 31MAR2002
;
RUN;
TITLE "Listing of Data Set DATES";
PROC PRINT DATA = Dates NOOBS;
RUN;

/*Functions That Extract the Year, Month, Day, etc. from a SAS Date */
/*Function: YEAR*/
/*Purpose: To extract the year from a SAS date.*/
/*Syntax: YEAR(date)*/
/* 		date is a SAS date value. */
/**/
/*Function: QTR*/
/*Purpose: To extract the quarter (January–March = 1, April–June = 2, etc.) from a SAS date.*/
/*Syntax: QTR(date)*/
/**/
/*Function: MONTH*/
/*Purpose: To extract the month of the year from a SAS date (1 = January, 2=February, etc.).*/
/*Syntax: MONTH(date)*/
/* 		date is a SAS date value. */
/**/
/*Function: WEEK*/
/*Purpose: To extract the week number of the year from a SAS date (the week-number value is a number from 0 */
/*		 to 53 or 1 to 53, depending on the optional modifier).*/
/*Syntax: WEEK(<date> <,'modifier'>))*/
/*		date is a SAS date value. If date is omitted, the WEEK function returns the week number of the */
/*		current date. modifier is an optional argument that determines how the week-number value is */
/*		determined. If modifier is omitted, the first Sunday of the year is week 1. For dates prior to */
/*		this date, the WEEK function returns a 0. */
/**/
/*Function: WEEKDAY*/
/*Purpose: To extract the day of the week from a SAS date (1 = Sunday, 2=Monday, etc.).*/
/*Syntax: WEEKDAY(date)*/
/*		date is a SAS date value*/
/**/
/*Program 4.5: Demonstrating the functions YEAR, QTR, MONTH, WEEK, DAY, and WEEKDAY*/
/*DATA Date_Functions;*/
/*	SET Dates(DROP = Date2);*/
/*	Year = YEAR(Date1);*/
/*	Quarter = QTR(Date1);*/
/*	Month = MONTH(Date1);*/
/*	Week = WEEK(Date1);*/
/*	Day_of_Month = DAY(Date1);*/
/*	Day_of_Week = WEEKDAY(Date1);*/
/*RUN;*/
/*TITLE "Listing of Data Set DATE_FUNCTIONS";*/
/*PROC PRINT DATA = Date_Functions NOOBS;*/
/*RUN;*/
/**/
/*Functions That Extract Hours, Minutes, and Seconds from SAS Datetime and Time Values */
/*Function: HOUR*/
/*Purpose: To extract the hour from a SAS datetime or time value.*/
/*Syntax: HOUR(time or dt)*/
/*		time or dt is a SAS time or datetime value.*/
/**/
/*Function: MINUTE*/
/*Purpose: To extract the minute value from a SAS datetime or time value.*/
/*Syntax: MINUTE(time or dt)*/
/*		time or dt is a SAS time or datetime value.*/
/**/
/*Function: SECOND*/
/*Purpose: To extract the second value from a SAS datetime or time value.*/
/*Syntax: SECOND(time or dt)*/
/*		time or dt is a SAS time or datetime value.  */
/**/
/*Program 4.6: Demonstrating the HOUR, MINUTE, and SECOND functions*/
DATA Time;
	DT = '01jan1960:5:15:30'dt;
	T = '10:05:23't;
	Hour_dt = HOUR(DT);
 	Hour_time = HOUR(T);
 	Minute_dt = MINUTE(DT);
 	Minute_time = MINUTE(T);
	Second_dt = SECOND(DT);
	Second_time = SECOND(T);
	FORMAT DT datetime.;
RUN;
TITLE "Listing of Data Set TIME";
PROC PRINT DATA = Time NOOBS HEADING = H;
RUN;

/*Functions That Extract the Date or Time from SAS Datetime Values */
/*Function: DATEPART*/
/*Purpose: To compute a SAS date from a SAS datetime value.*/
/*Syntax: DATEPART(date-time-value)*/
/*		date-time-value is a SAS datetime value. */
/**/
/*Function: TIMEPART*/
/*Purpose: To extract the time part of a SAS datetime value.*/
/*Syntax: TIMEPART(date-time-value)*/
/*		Date-time-value is a SAS datetime value. */
/*Program 4.7: Extracting the date part and time part of a SAS datetime value*/
DATA Pieces_Parts;
	DT = '01jan1960:5:15:30'dt;
	Date = datepart(DT);
	Time = timepart(DT);
	FORMAT DT datetime. Time time. Date date9.;
RUN;
TITLE "Listing of Data Set PIECES_PARTS";
PROC PRINT DATA = Pieces_Parts NOOBS;
RUN;
