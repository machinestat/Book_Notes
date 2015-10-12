LIBNAME sasts "C:\Books\SAS\Practical Time Series Analysis";

/*Aggregation*/
/*Observations of continuous series are usually sampled at distinct points in time, leading to discrete*/
/*equidistant time series. Such original data sources already have the form of a discrete equidistant*/
/*time series oberved with a very high frequency and can be performed aggregations in many ways based on */
/*the current interest of the analysis and the nature of the time series.*/

/*PROC TIMESERIES*/
/*Example: a series of recordings of a counter at a photocopying machine*/
/*Code genderating the number of copies between two serice visits*/
PROC PRINT DATA = sasts.copy_machine (OBS = 10);
RUN;
DATA a;
    SET sasts.copy_machine;
    number = DIF(counter);
    days = DIF(date);
    average_number = number / days;
RUN;
PROC SGPLOT DATA = a;
    SERIES x = date y =number/MARKERS;
    SERIES x = date y = average_number/MARKERS y2axis;
RUN;

/*A first application of PROC TIMESERIES*/
PROC TIMESERIES DATA = a OUT = b;
    ID date INTERVAL = month ACCUMULATE = total SETMISSING = missing;
    VAR number;
RUN;
PROC SGPLOT DATA = b;
    SERIES x = date y = number/MARKERS;
RUN;

/*Interpolation Using PROC EXPAND*/
/*Interpolation of Time Series*/
/*It is possible interpolate data series in order to find reasonable values for the missing observations.*/
/*SAS offers a precedure for interpolation: PROC EXPAND.*/
/*PROC EXPAND interpolates missing observations in time series by simple curve-fitting methods.*/
/*Example: A first application of PROC EXPAND*/
PROC EXPAND DATA = sasts.copy_machine OUT = joinB TO = month;
    CONVERT counter = interpolated / METHOD = join;
    ID date;
RUN;
DATA d;
    MERGE sasts.copy_machine joinB;
    BY date;
RUN;
PROC SGPLOT DATA = d;
    SERIES x = date y = counter/MARKERS;
    SERIES x = date y = interpolated/MARKERS;
RUN;

/*Calculating the number of copies using the interpolate series*/
DATA e;
    SET joinb;
    number = DIF(interpolated);
RUN;
PROC SGPLOT data = e;
    SERIES x = date y = number/MARKERS;
RUN;

/*An example of the transformation facilities in PROC EXPAND*/
PROC EXPAND DATA = sasts.copy_machine OUT = joinB TO = month;
    CONVERT counter = number / TRANSFORMOUT = (DIF 1) METHOD = join;
    ID date;
RUN;
