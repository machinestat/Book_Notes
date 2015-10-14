/*Simple Exponential Smoothing*/
/*The technique of exponential smoothing is often applied for forecasting because*/
/*the idea is simple and very intuitive, and it is easily extended to cover more*/
/*complicated situations than might be expected at first glance.*/
/*The idea underlying exponential smoothing is that the series around some smooth curve*/
/*that might be considered as the true, however, which is varying over time.*/
/*This method is named exponential smoothing because the smoothed series is defined as*/
/*a weighted average of the observations with exponentially declining weights.*/
LIBNAME sasts "C:\Books\SAS\Practical Time Series Analysis";
PROC PRINT DATA = sasts.fertility (OBS = 20);
RUN;
/*A simple application of PROC ESM*/
PROC ESM DATA = sasts.fertility OUTFOR = out BACK = 80 LEAD = 80 PRINT = all;
    ID year INTERVAL = year;
    FORECAST fertility;
RUN;
PROC PRINT DATA = out (OBS = 10);
RUN;
PROC SGPLOT DATA = out;
    SERIES x = year y = actual/MARKERS;
    SERIES x = year y = predict/MARKERS;
    YAXIS VALUES = (0 to 4500 BY 500);
    REFLINE '01JUL1929'D / AXIS = x;
RUN;
