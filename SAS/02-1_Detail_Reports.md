---
Title: "Detail Report"
output: pdf_document
---

```
*-------------------------------------------------------------------*
|Example 1.1 Listing Selected Observations in a Specific Order      |
|This report lists observations from the HOUSING data set. It       |
|presents data about houses for sale within a specific price range  |
|and arranges the observations in descending order of price. Each   |
|row in the report corresponds to one observation in the HOUSING    |
|data set. Each column corresponds to one variable. The data set    |
|must be sorted before the PROC PRINT step. A VAR statement within  |
|the PROC PRINT step selects the variables to list in the report. A |
|WHERE statement within the PROC PRINT step selects the observations|
|to list in the report.                                             |
--------------------------------------------------------------------*;


* Create the library for data sets;
LIBNAME reports 'C:\Data\Book\Stats\SAS Report Guide';
* First sort the data by descending values of the variable PRICE;
PROC SORT DATA = reports.housing out = housing;
	BY DESCENDING price;
RUN;
* Create a format that can associate meaningful descriptions to 
the numeric values of the variable ZONE.;
PROC FORMAT;
	VALUE 	$zonefmt	'1'='North Ridge'
						'2'='Inside Beltline'
						'3'='Southside'
						'4'='East Lake'
						'5'='Westend'
						'6'='Mountain Brook'
						'7'='Ensley'
						'8'='Roebuck';
RUN;

* Print the sorted data set.Print the number of observations in the
data set and specify explanatory text to print with the number. 
Specify the split character that controls line breaks in column 
headings. Format all pages of a multipage report uniformly when 
sending output to the LISTING destination.;

PROC PRINT DATA = housing NOOBS SPLIT = "/" UNIFORM
			N = 'Total Available Properties within Price Range:';
	TITLE 'Selected Listing of Local Residential Properties';
	TITLE2 'Price Range $200,000 to $350,000';
	*Select the observations to include in the report.;
	WHERE price between 200000 and 350000;
	*List the variables in the report.;
	VAR zone type address price bedr bath sqfeet age;
	*Associate formats with variables.;
	FORMAT sqfeet comma5. price dollar9. zone $zonefmt.;
	*Label the variables in the report.;
	LABEL zone='Residential/Zone'
			type='House/Style'
			address='Address'
			price='Listing/Price'
			bedr='Bedrooms'
			bath='Bathrooms'
			sqfeet='Square/Feet'
			age='Age';
RUN;
```

```
*-------------------------------------------------------------------*
|Example 1.2 Ordering the Rows of a Report                          |
|This detail report lists specific data about houses for sale within|
|the price range of $200,000 to $350,000 and is similar to 			|
|Example 1.1. This report, however, does not require that you sort  |
|the data set prior to producing the report. Statements within PROC |
|REPORT order the rows first by residential zone and then within 	|
|each residential zone, by descending price. Each row in the report |
|corresponds to one observation in the HOUSING data set. Each column|
|corresponds to one variable.                                       |
--------------------------------------------------------------------*;

* Create a format that can associate meaningful descriptions to 
the numeric values of the variable ZONE.;
PROC FORMAT;
	VALUE 	$zonefmt	'1'='North Ridge'
						'2'='Inside Beltline'
						'3'='Southside'
						'4'='East Lake'
						'5'='Westend'
						'6'='Mountain Brook'
						'7'='Ensley'
						'8'='Roebuck';
RUN;

*Send output to the SAS procedure output destination;
*Specify the split character to control "/" line breaks in column headings.*;
*Underline all column headers and Override the default 
spacing of two blank characters between columns when 
sending output to the LISTING destination.*;

PROC REPORT DATA = housing NOWINDOWS
			SPLIT = '/' 
			HEADLINE SPACING = 1;
	TITLE 'Listing of Local Residential Properties';
	TITLE2 'Price Range $200,000 to $350,000';
	TITLE3 'Listed by Zone';

	*Include today?s date in the footnote text.*;
	FOOTNOTE "Listing Produced on %sysfunc(today(),worddate12.)";

	*Select the observations*;
	WHERE price between 200000 and 350000;
 
	*List the columns*;
	COLUMNS zone price type address bedr bath sqfeet age;
	DEFINE zone / ORDER FORMAT = $zonefmt15. WIDTH = 15 
					'Residential/Zone';
	DEFINE price / ORDER DESCENDING FORMAT = dollar10. 
					WIDTH = 10 'Listing/Price';
	DEFINE type / DISPLAY FORMAT = $9.'House/Style';
	DEFINE address / FORMAT = $25. WIDTH = 25 'Address';
	DEFINE bedr / FORMAT = 2. WIDTH = 8 'Bedrooms';
	DEFINE bath / FORMAT = 3.1 WIDTH = 9 'Bathrooms';
	DEFINE sqfeet / FORMAT = comma6. WIDTH = 6 'Square/Feet';
	DEFINE age / FORMAT = 3. 'Age';

	*Write a blank line after the last row for each unique value 
	of the order variable ZONE.;

	BREAK AFTER zone / SKIP;
RUN;
```

```
*-------------------------------------------------------------------*
|Example 1.3 Placing Data That Is Constant for a Category in Titles |
|Order a data set by categories and list the observations. Write    |
|information that is constant for a category in the page titles     |
|rather than in columns. Each row in the report presents information|
|about one observation.												|
--------------------------------------------------------------------*;

*Suppress the automatic printing of BY lines in subsequent procedure output;
OPTIONS NOBYLINE NOCENTER MISSING = '0';

PROC FORMAT;
	VALUE	size	1 = 'Very small -- a window or hanging feeder only'
					2 = 'Small (< 1,000 sq ft/100 sq m)'
					3 = 'Medium (1,001-4,000 sq ft/101-375 sq m)'
					4 = 'Large (> 4,000 sq ft/375 sq m)';
	VALUE desc		1 = 'no vegetation (pavement only)'
					2 = 'garden or courtyard'
					3 = 'mix of natural and landscaped vegetation'
					4 = 'landscaped yard (with lawn and plantings)'
					5 = 'natural vegetation (woods, fields)'
					6 = 'desert: natural or landscaped'
					7 = 'other type';
	VALUE pop 		1 = '1 to 5,000'
					2 = '5,001 to 25,000'
					3 = '25,001 to 100,000'
					4 = 'More than 100,000';
	VALUE dens 		1 = 'Rural'
					2 = 'Rural/suburban mix'
					3 = 'Suburban'
					4 = 'Urban';
	VALUE $species  'amecro'='American crow'
					'amegfi'='American goldfinch'
					'amerob'='American robin'
					'amtspa'='American tree sparrow'
					'bkcchi'='Black-capped chickadee'
					'blujay'='Blue jay'
					'borchi'='Boreal chickadee'
					'brncre'='Brown creeper'
					'chispa'='Chipping sparrow'
					'comgra'='Common grackle'
					'comred'='Common redpoll'
					'coohaw'='Cooper''s hawk'
					'daejun'='Dark-eyed junco'
					'dowwoo'='Downy woodpecker'
					'eursta'='European starling'
					'foxspa'='Fox sparrow'
					'haiwoo'='Hairy woodpecker'
					'houfin'='House finch'
					'houspa'='House sparrow'
					'logshr'='Loggerhead shrike'
					'mallar'='Mallard'
					'moudov'='Mourning dove'
					'norcar'='Northern cardinal'
					'norfli'='Norther flicker'
					'norshr'='Northern shrike'
					'pilwoo'='Pileated woodpecker'
					'pinsis'='Pine siskin'
					'purfin'='Purple finch'
					'rebnut'='Red-breasted nuthatch'
					'rebwoo'='Reb-bellied woodpecker'
					'rewbla'='Red-winged blackbird'
					'rocdov'='Rock dove'
					'shshaw'='Sharp-shinned hawk'
					'sonspa'='Song sparrow'
					'tuftit'='Tufted titmouse'
					'whbnut'='White-breasted nuthatch'
					'whtspa'='White-throated sparrow';
	VALUE 	everseen 	0=' '
				1='****';
run;

*Arrange the observations by site ID.;
PROC SORT DATA = reports.feederbirds OUT = feederbirds;
	BY id;
RUN;

*Use the labels of the report variables in the PROC PRINT;
*Include in the BY statement the variables with values 
that are constant for each site ID.;
PROC PRINT DATA = feederbirds LABEL;
	BY ID	NOTSORTED countsitesize
			NOTSORTED countsitedesc
			NOTSORTED density
			NOTSORTED pop;
	ID species;
	TITLE "Project FeederWatch Counts for Ten Observation
				Periods in Minnesota during 2002-2003";
	*Substitute the current values of the BY variables in 
	the next three TITLE statements where enclosed by 
	#BYVAL and parentheses.;

	TITLE2 "Counts for Site #byval(id)";
	TITLE3 "Site Description: #byval(countsitesize) in
				#byval(countsitedesc)";
	title4 "Community: #byval(density) with a population
		of #byval(pop)";
	
	FOOTNOTE1 "Key to Ten Observation Periods:";
	FOOTNOTE2 	' 1: 09nov2002-22nov2002 '
				' 2: 23nov2002-06dec2002 '
				' 3: 07dec2002-20dec2002 '
				' 4: 21dec2002-03jan2003';
	FOOTNOTE3 	' 5: 04jan2003-17jan2003 '
				' 6: 18jan2003-31jan2003 '
				' 7: 01feb2003-14feb2003 '
				' 8: 15feb2003-28feb2003';
	FOOTNOTE4 	' 9: 01mar2003-14mar2003 '
				' 10: 15mar2003-28mar2003';

	*List the variables whose values vary within each site.;
	VAR everseen p1-p10;

	FORMAT countsitesize size. countsitedesc desc.
			density dens. pop pop.
			species $species. everseen everseen.;
	LABEL 	species='Species'
			p1='P1'
			p2='P2'
			p3='P3'
			p4='P4'
			p5='P5'
			p6='P6'
			p7='P7'
			p8='P8'
			p9='P9'
			p10='P10'
			everseen='Ever Seen';
run;

*Reset options to their default settings.;
OPTIONS BYLINE CENTER MISSING = '.';
```

```
*---------------------------------------------------------------------*
|Example 2.4 Summarizing the Rows of a Report                         |
|Goal: List observations in a data set and summarize selected numeric |
|variables by groups. Present an overall summarization of the         |
|selected numeric variables at the end of the report.                 |
*---------------------------------------------------------------------*;

*Create formats for TYPE and SERVICE.;
PROC FORMAT;
		VALUE 	$type	   'res' = 'Residential'
						   'com' = 'Commercial';
		VALUE   $service   'gen' = 'General Service'
		                   'wtr' = 'Water Heating'
						   'op'  = 'Off Peak'
						   'spc' = 'Space Heating'
						   'fld' = 'Flood Lights'
						  'area' = 'Area Lights'
						   'oth' = 'Other Service';
RUN;

TITLE 'Regional Energy';
TITLE2 'Quarterly Use by Residential and Commercial Customers';

PROC REPORT DATA = reports.poweruse NOWINDOWS;
	*List the columns and place a column heading above a group of variables;
	COLUMN type service ('-First Quarter-' jan feb mar)
						('-Second Quarter-' apr may jun);
	DEFINE type / ORDER FORMAT = $type. WIDTH = 11 ' ';
	DEFINE service / ORDER FORMAT = $service. WIDTH = 15 'Service';

	*Calculate the SUM statistic for each of the analysis variables;
	DEFINE jan / ANALYSIS SUM 'Janaury' WIDTH = 8 FORMAT = COMMA6.;
	DEFINE feb / ANALYSIS SUM 'February' WIDTH = 8 FORMAT = COMMA6.;
	DEFINE mar / ANALYSIS SUM 'March' WIDTH = 8 FORMAT = COMMA6.;
	DEFINE apr / ANALYSIS SUM 'April' WIDTH = 8 FORMAT = COMMA6.;
	DEFINE may / ANALYSIS SUM 'May' WIDTH = 8 FORMAT = COMMA6.;
	DEFINE jun / ANALYSIS SUM 'June' WIDTH = 8 FORMAT = COMMA6.;

	*Write a summary line after the last row for each value of TYPE;
	*When sending output to the LISTING destination. place a double overline;
	*and a double underline above and below the summary row, and skip a line;
	*after the double underline.;
	BREAK AFTER type / SUMMARIZE DOL DUL SKIP;

	*Write a summary line at the end of the report. Sum the ;
	*analysis variables over all observations.;
	RBREAK AFTER / SUMMARIZE DOL DUL SKIP;
RUN;


OUTPUT:

                                         Regional Energy     
                      Quarterly Use by Residential and Commercial Customers

                                   --------First Quarter--------  --------Second Quarter--------
                  Service           Janaury  February     March     April       May      June
     Commercial   Area Lights         6,526    11,999    17,533    10,221    17,218     8,857
                  Flood Lights       10,911    12,648    15,502     9,120     8,624    18,338
                  General Service     1,203       641       728     1,039     1,156       782
                  Off Peak           15,062    15,635     9,509    11,717    11,456    12,461
                  Other Service       1,390     1,672     1,638     1,282     1,654     1,915
                  Space Heating         111        85       121       109       125       103
                  Water Heating         160       168       130       187       101       101
     ===========                   ========  ========  ========  ========  ========  ========
     Commercial                      35,363    42,848    45,161    33,675    40,334    42,557
     ===========                   ========  ========  ========  ========  ========  ========

     Residential  Area Lights           118       116        91        92        95       137
                  Flood Lights           96        89        75        87        75        82
                  General Service    22,281    21,505    22,556    22,784    25,977    25,371
                  Off Peak            1,152     1,362       698     1,047       534     1,492
                  Other Service         286       238       109        33       158       465
                  Space Heating       8,280    10,984    10,111    13,234    13,723    11,072
                  Water Heating       9,589    10,625    14,160    18,130     8,592     7,654
     ===========                   ========  ========  ========  ========  ========  ========
     Residential                     41,802    44,919    47,800    55,407    49,154    46,273
     ===========                   ========  ========  ========  ========  ========  ========

                                   ========  ========  ========  ========  ========  ========
                                     77,165    87,767    92,961    89,082    89,488    88,830
                                   ========  ========  ========  ========  ========  ========
```
Using PROC PRINT to produce similar report:
```
*First we need to sort the data;
PROC SORT DATA = reports.poweruse OUT = poweruse;
    BY type service;
RUN;

TITLE "Regional Energy";
TITLE2 "Quarterly Use by Residential and Commercial Customers";

*Use variable labels as column headings.;
PROC PRINT DATA = poweruse LABEL;
	ID type;
	BY type;
	VAR service jan feb mar apr may jun;

	*Sum the values of the numeric variables for each BY group and overall.;
	SUM jan feb mar apr may jun;

	*Add labels and formats;
	LABEL type = '00'x
		  service = 'Service'
		  jan = 'January'
		  feb = 'February'
		  mar = 'March'
		  apr = 'April'
		  may = 'May'
		  jun = 'June';
	FORMAT type $type. service $service. jan--jun comma6.;
RUN;
```
Use PROC REPORT to ummarize over all observations and summarize observations within groups. Summarize specific variables within an observation and add these summaries as columns in the report. 

```
OPTIONS LS = 120 PS = 45;

TITLE "Regional Energy";
TITLE2 "Quarterly Use by Residential and Commercial Customers";

PROC REPORT DATA = poweruse NOWINDOWS SPLIT = '/';
    COLUMN type service ('-First Quarter-' jan feb mar quarter1)
						('-Second Quarter-' apr may jun quarter2)
						total;
	DEFINE type / ORDER FORMAT = $type. WIDTH = 11 ' ';
	DEFINE service / ORDER FORMAT = $service. WIDTH = 15 'Service';
	DEFINE jan / ANALYSIS SUM 'January' WIDTH = 8 FORMAT = comma8.;
	DEFINE feb / ANALYSIS SUM 'February' WIDTH = 8 FORMAT = comma8.;
	DEFINE mar / ANALYSIS SUM 'March' WIDTH = 8 FORMAT = comma8.;
	DEFINE apr / ANALYSIS SUM 'April' WIDTH = 8 FORMAT = comma8.;
	DEFINE may / ANALYSIS SUM 'May' WIDTH = 8 FORMAT = comma8.;
	DEFINE jun / ANALYSIS SUM 'June' WIDTH = 8 FORMAT = comma8.;

	*Identify the computed columns;
	DEFINE quarter1 / COMPUTED 'Quarter/Total' WIDTH = 8 FORMAT = comma8.;
	DEFINE quarter2 / COMPUTED 'Quarter/Total' WIDTH = 8 FORMAT = comma8.;
	DEFINE total / COMPUTED 'Total' WIDTH = 8 FORMAT = comma8.;

	*Calculate the values of each computed variable.;
	COMPUTE quarter1;
		quarter1 = sum(jan.sum, feb.sum, mar.sum);
	ENDCOMP;

	COMPUTE quarter2;
		quarter2 = sum(apr.sum, may.sum, jun.sum);
	ENDCOMP;

	COMPUTE total;
		total = sum(quarter1, quarter2);
	ENDCOMP;

	BREAK AFTER type / SUMMARIZE DOL DUL SKIP;
RUN;

And the output is:

                                                    Regional Energy
                                 Quarterly Use by Residential and Commercial Customers

                               ------------First Quarter------------  ------------Second Quarter------------
                                                              Quarter                                 Quarter
              Service           January  February     March     Total     April       May      June     Total     Total
 Commercial   Area Lights         6,526    11,999    17,533    36,058    10,221    17,218     8,857    36,296    72,354
              Flood Lights       10,911    12,648    15,502    39,061     9,120     8,624    18,338    36,082    75,143
              General Service     1,203       641       728     2,572     1,039     1,156       782     2,977     5,549
              Off Peak           15,062    15,635     9,509    40,206    11,717    11,456    12,461    35,634    75,840
              Other Service       1,390     1,672     1,638     4,700     1,282     1,654     1,915     4,851     9,551
              Space Heating         111        85       121       317       109       125       103       337       654
              Water Heating         160       168       130       458       187       101       101       389       847
 ===========                   ========  ========  ========  ========  ========  ========  ========  ========  ========
 Commercial                      35,363    42,848    45,161   123,372    33,675    40,334    42,557   116,566   239,938
 ===========                   ========  ========  ========  ========  ========  ========  ========  ========  ========

 Residential  Area Lights           118       116        91       325        92        95       137       324       649
              Flood Lights           96        89        75       260        87        75        82       244       504
              General Service    22,281    21,505    22,556    66,342    22,784    25,977    25,371    74,132   140,474
              Off Peak            1,152     1,362       698     3,212     1,047       534     1,492     3,073     6,285
              Other Service         286       238       109       633        33       158       465       656     1,289
              Space Heating       8,280    10,984    10,111    29,375    13,234    13,723    11,072    38,029    67,404
              Water Heating       9,589    10,625    14,160    34,374    18,130     8,592     7,654    34,376    68,750
 ===========                   ========  ========  ========  ========  ========  ========  ========  ========  ========
 Residential                     41,802    44,919    47,800   134,521    55,407    49,154    46,273   150,834   285,355
 ===========                   ========  ========  ========  ========  ========  ========  ========  ========  ========
```

```
*----------------------------------------------------------*
|Example 2.6 Suppressing the Display of Specific Columns   |
|List observations in a data set and summarize selected    |
|numeric variables. Summarize over all observations and    |
|summarize within groups. Summarize specific variables     |
|within an observation and add these summaries as columns  |
|in the report. Display the summary columns. Do not display|
|the variables used to calculate the summaries.            |
|----------------------------------------------------------*;

*Create formats for TYPE and SERVICE.;

proc format;
	value $type 'res'='Residential'
				'com'='Commercial';
	value $service 'gen'='General Service'
					'wtr'='Water Heating'
					'op' ='Off Peak'
					'spc'='Space Heating'
					'fld'='Flood Lights'
					'area'='Area Lights'
					'oth'='Other Service';
run;
options ls=120 ps=45;
title 'Regional Energy';
title2 'Quarterly Use by Residential and Commercial Customers';
proc report data=poweruse nowindows split='/';
	column type service jan feb mar apr may jun
						quarter1 quarter2 total;
	define type / order format=$type. width=11 ' ';
	define service / order format=$service. width=15 'Service';
	define jan / analysis sum noprint;
	define feb / analysis sum noprint;
	define mar / analysis sum noprint;
	define apr / analysis sum noprint;
	define may / analysis sum noprint;
	define jun / analysis sum noprint;
	define quarter1 / computed 'First/Quarter/Total'
					width=8	format=comma8.;
	define quarter2 / computed 'Second/Quarter/Total'
					width=8 format=comma8.;
	define total / computed 'Total' width=8
					format=comma8.;

	compute quarter1;
		quarter1=sum(jan.sum,feb.sum,mar.sum);
	endcomp;
	compute quarter2;
		quarter2=sum(apr.sum,may.sum,jun.sum);
	endcomp;

	compute total;
		total=sum(quarter1,quarter2);
	endcomp;

	break after type / summarize dol dul skip;
	rbreak after / summarize dol dul skip;
run;

output:

Regional Energy
Quarterly Use by Residential and Commercial Customers

                                   First    Second
                                 Quarter   Quarter
               Service             Total     Total     Total
  Commercial   Area Lights        36,058    36,296    72,354
               Flood Lights       39,061    36,082    75,143
               General Service     2,572     2,977     5,549
               Off Peak           40,206    35,634    75,840
               Other Service       4,700     4,851     9,551
               Space Heating         317       337       654
               Water Heating         458       389       847
  ===========                   ========  ========  ========
  Commercial                     123,372   116,566   239,938
  ===========                   ========  ========  ========

  Residential  Area Lights           325       324       649
               Flood Lights          260       244       504
               General Service    66,342    74,132   140,474
               Off Peak            3,212     3,073     6,285
               Other Service         633       656     1,289
               Space Heating      29,375    38,029    67,404
               Water Heating      34,374    34,376    68,750
  ===========                   ========  ========  ========
  Residential                    134,521   150,834   285,355
  ===========                   ========  ========  ========

                                ========  ========  ========
                                 257,893   267,400   525,293
                                ========  ========  ========

```

