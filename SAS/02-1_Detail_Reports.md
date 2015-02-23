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

	*Include today’s date in the footnote text.*;
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