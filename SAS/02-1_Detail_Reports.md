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
```

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
