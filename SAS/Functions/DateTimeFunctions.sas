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

/*Functions That Work with Date, Datetime, and Time Intervals*/
/**/
/*Function: INTCK*/
/*Purpose: To return the number of intervals between two dates, two times, or two datetime values. */
/*		 To be more accurate, the INTCK function counts the number of times a boundary has been */
/*		 crossed going from the first value to the second. */
/*Syntax: INTCK('interval<Multiple> <.shift>', start-value, end-value)*/
/**/
/*Function: INTNX*/
/*Purpose: To return the date after a specified number of intervals have passed.*/
/*Syntax: INTNX('interval', start-date, increment <,'alignment'>) */
/**/
/*Program 4.8: Demonstrating the INTNX function (with the SAMEDAY alignment)*/
*A dentist wants to see each of his patients in six months for a followup
visit. However, if the date in six months falls on a Saturday or Sunday,
he wants to pick a random day in the following week.; 
DATA Dental;
	INPUT Patno : $5. Visit_date : mmddyy10.;
	FORMAT Visit_date weekdate.;
DATALINES;
001 1/14/2009
002 1/17/2009
003 1/18/2009
004 1/19/2009
005 1/19/2009
006 1/20/2009
007 1/11/2009
008 1/17/2009
;
RUN;
TITLE "Listing of data set DENTAL";
PROC PRINT DATA = Dental NOOBS;
RUN;
DATA Followup;
	SET Dental;
	Six_Months = INTNX('month', Visit_date, 6, 'sameday');
	*Check if weekend;
 	DayofWeek = WEEKDAY(Six_Months);
 	*Keep track of actual day for testing purposes;
 	Actual = Six_Months;
 	*If Sunday add random integer between 1 and 5;
 	IF DayofWeek = 1 THEN
 	Six_Months = Six_Months + CEIL(RANUNI(0)*5);
 	*If Saturday, add a random integer between 2 and 6;
 	ELSE IF DayofWeek = 7 THEN
 	Six_Months = Six_Months + CEIL(RANUNI(0)*5 + 1);
run;
TITLE "Six Month Appointment Dates";
PROC REPORT DATA = Followup NOWD HEADLINE;
	COLUMNS Patno Visit_date Actual Six_months;
 	DEFINE Patno / DISPLAY "Patient Number" WIDTH = 7;
 	DEFINE Visit_date / DISPLAY "Initial Date" WIDTH = 15 FORMAT = weekdate.;
 	DEFINE Actual / DISPLAY "Actual Day" WIDTH = 15 FORMAT = weekdate.;
 	DEFINE Six_Months / DISPLAY "Six Month Appt." WIDTH = 15
	FORMAT = weekdate.;
RUN;
QUIT; 

/*Function: YRDIF*/
/*Purpose: To return the difference in years between two dates(includes fractional parts of a year). */
/*Syntax: YRDIF(start-date, end-date, 'basis') */
/*		basis is an argument that controls how SAS computes the result. The first value is used to specify */
/*		the number of days in a month; the second value (after the slash) is used to specify the number of */
/*		days in a year. */
/*		A value of 'ACT/ACT' (alias 'ACTUAL') uses the actual number of days in a month and the actual number */
/*		of days in a year (either 365 or 366 days, depending on whether there are leap years involved). */
/*		'30/360' Uses 30-day months and 360-day years in the calculation.*/
/*		'ACT/365' Uses the actual number of days between the two dates, but uses 365-day years, even if a */
/*				  leap year is in the interval.*/
/*		'ACT/360' Uses the actual number of days between the two dates, but uses 360-day years.*/
/*Program 4.9: Program to demonstrate the date interval functions*/
DATA Period;
	SET Dates;
	Interval_Month = INTCK('month', Date1, Date2);
	Interval_Year = INTCK('year', Date1, Date2);
	Year_Diff = YRDIF(Date1, Date2, 'actual');
	Interval_Qtr = INTCK('qtr', Date1, Date2);
	Next_Month = INTNX('month', Date1, 1);
	Next_Year = INTNX('year', Date1, 1);
	Next_Qtr = INTNX('qtr', Date1, 1);
	Six_Month = INTNX('month', Date1, 6);
	
	FORMAT Next: Six_Month date9.;
RUN;
TITLE "Listing of Data Set PERIOD";
PROC PRINT DATA = Period HEADING = H;
	ID Date1 Date2;
RUN;

/*Function That Computes Dates of Standard Holidays*/
/*Function: HOLIDAY*/
/*Purpose: Returns a SAS date, given a holiday name and a year.*/
/*Syntax: HOLIDAY (holiday, year)*/
/*Program 4.10: Demonstrating the HOLIDAY function*/
DATA Salary;
	H1 = HOLIDAY('Newyear', 2005);
	IF WEEKDAY(H1) = 7 THEN H1 = H1 + 2;
 	ELSE IF WEEKDAY(H1) = 1 THEN H1 = H1 + 1;
 	H2 = HOLIDAY('MLK',2005);
 	H3 = HOLIDAY('USpresidents',2005);
 	H4 = HOLIDAY('Easter',2005)-2;
 	array H[4];
 	First = '01Jan2005'd; *Saturday;
 	Second = '31Mar2005'd; *Thursday;
 	Work = intck('weekday',First,Second);
 	/* if holiday falls between the First and Second date,
 	decrement number of working days */
 	DO i = 1 TO 4;
 		IF First LE H[i] LE Second THEN Work = Work - 1;
 	END;
 	Salary = 500 * Work;
 	FORMAT First Second mmddyy10. Salary dollar10.;
 	KEEP First Second Work Salary;
RUN;
TITLE "Listing of SALARY";
PROC PRINT DATA = SALARY NOOBS;
RUN; 

/*Functions That Work with Julian Dates */
/*Function: DATEJUL*/
/*Purpose: To convert a Julian date into a SAS date.*/
/*Syntax: DATEJUL(jul-date)*/
/*		jul-date is a numerical value representing the Julian date in the form dddyy or dddyyyy*/
/**/
/*Function: JULDATE*/
/*Purpose: To convert a SAS date into a Julian date.*/
/*Syntax: JULDATE(date)*/
/*		date is a SAS date. */
/**/
/*Function: JULDATE7*/
/*Purpose: To convert a SAS date into seven-digit Julian date.*/
/*Syntax: JULDATE7(date)*/
/*		date is a SAS date. */
/*Program 4.11: Demonstrating the three Julian date functions*/
***Note: option YEARCUTOFF set to 1920;
OPTIONS YEARCUTOFF = 1920;
DATA Julian;
	INPUT Date : date9. Jdate;
	Jdate_to_SAS = DATEJUL(Jdate);
	SAS_to_Jdate = JULDATE(Date);
	SAS_to_Jdate7 = JULDATE7(Date);
	FORMAT Date Jdate_to_SAS mmddyy10.;
DATALINES;
01JAN1960 2003365
15MAY1901 1905001
21OCT1946 5001
;
RUN;
TITLE "Listing of Data Set JULIAN";
PROC PRINT DATA = Julian NOOBS;
	VAR Date SAS_to_Jdate SAS_to_Jdate7 Jdate Jdate_to_SAS;
RUN; 
