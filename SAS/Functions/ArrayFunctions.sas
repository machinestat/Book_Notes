/*Function: DIM*/
/*		  It returns the number of elements in an array, given the array name as its argument. */
/*Purpose: To determine the number of elements in an array. */
/*Syntax: DIM(array-name<,dimension>) */
/*		or*/
/*		DIMn(array-name) where n is a dimension of a multidimensional array*/
/*Program 5.1: Setting all numeric values of 999 to missing and all character values of 'NA' to missing*/
DATA Mixed;
	INPUT X1-X5 A $ B $ Y Z;
DATALINES;
1 2 3 4 5 A b 6 7
2 999 6 5 3 NA C 999 10
5 4 3 2 1 na B 999 999
;
RUN;
DATA Array_1;
	SET Mixed;
	ARRAY nums[*] _NUMERIC_;
	ARRAY chars[*] _CHARACTER_;
	DO i = 1 TO DIM(nums);
		IF nums[i] = 999 THEN nums[i] = .;
	END;
	
	DO i = 1 TO DIM(chars);
		IF UPCASE(chars[i]) = 'NA' THEN chars[i] = ' ';
	END;
	DROP i;
RUN;
PROC PRINT DATA = Array_1 NOOBS;
RUN;

/*Program 5.2: Creating a macro to compute and print out the number of numeric and character variables in a SAS data set */
%macro count(Dat = /*Data set Name*/);
	TITLE1 "*** Statistics for Data Set &Dat ***";
	DATA _NULL_;
		IF 0 THEN SET &Dat;
		ARRAY nums[*] _NUMERIC_;
		ARRAY chars[*] _CHARACTER_;
		n_nums = DIM(nums);
		n_chars = DIM(chars);
		FILE PRINT;
		PUT / "There are " n_nums "numeric variables and "
			  n_chars "character variables";
		STOP;
		RUN;
%mend count;
%count(Dat = Mixed)

/* DIM Function with Multidimensional Arrays*/
/* use DIM2(array-name)to determine the number of elements in the second dimension of an array*/
/* use DIM(Mult,2)to determine the number of elements in the second dimension of an array*/

/*Functions: HBOUND and LBOUND*/
/*Purpose: To determine the lower and upper bounds of the array when the array bounds do not run from 1 to n.*/
/*Syntax: HBOUND(array-name) or LBOUND(array-name)*/
/*the HBOUND and LBOUND functions become useful if explicitly set subscripts to start from a number other than one*/
/*the DIM function returns the number of elements, not the upper bound.*/
/*Program 5.3: Determining the lower and upper bounds of an array where the array bounds do not start from one */

DATA Array_2;
	ARRAY Income[1990:1995] Income1990-Income1995;
	ARRAY Tax[1990:1995] Tax1990-Tax1995;
	INPUT Income1990 - Income1995;
	DO Year = LBOUND(Income) TO HBOUND(Income);
		Tax[Year] = .25*Income[Year];
	END;
	FORMAT Income: Tax: dollar8.;
	DROP Year;
DATALINES;
50000 55000 57000 66000 65000 68000
;
RUN;
TITLE "Listing of Data Set ARRAY_2";
PROC PRINT DATA = Array_2 NOOBS;
RUN;
