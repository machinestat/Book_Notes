/*Function That Sorts Numeric Values*/
/*Function: CALL SORTN*/
/*Purpose: To sort the values of its numeric arguments in ascending order.*/
/*Syntax: CALL SORTN(<of> Var-1 <, ... Var-n>) */
/*		Var-n is a numeric variable. If you use a variable list in the form Var1–Varn,*/
/*		precede the list with the word "of".*/
/*		Arguments to the CALL SORTN routine cannot be constants. You may use*/
/*		array references as arguments to this routine as well */
/*Program 3.1: Program to grade quizzes, dropping the two lowest quiz scores (using CALL SORTN)*/
DATA Quiz_Scores;
	INPUT Name : $15. Quiz1-Quiz10;
	CALL SORTN(OF Quiz1-Quiz10);
	Grade = MEAN(OF Quiz3-Quiz10);
DATALINES;
George 78 90 90 95 88 . 100 98 95 90
Susan 100 100 100 100 100 100 . . . .
Maxwell 50 50 90 90 95 88 87 86 84 90
;
RUN;
TITLE "Listing of data set QUIZ_SCORES";
PROC PRINT DATA = Quiz_Scores NOOBS HEADING = H;
RUN;
  
/*Program 3.2: Another example of CALL SORTN using array elements as the arguments*/
DATA Top_Scores;
	INPUT Name : $15. Score1-Score8;
	ARRAY Score[8];
	CALL SORTN(OF Score[*]);
DATALINES;
King 8 4 6 7 9 9 9 4
Weisenbaum 9 9 8 . . 7 8 8
Chien 9 8 7 6 7 8 9 9
;
RUN;
TITLE "Listing of TOP_SCORES";
PROC PRINT DATA = Top_Scores;
	ID Name;
RUN;

/*Function That Sorts Character Values*/
/*Function: CALL SORTC*/
/*Purpose: To sort the values of its character arguments in ascending order.*/
/*Syntax: CALL SORTC(<of> Char-1 <, ... Char-n>)*/
/*		Char-n is a character variable. If you use a variable list in the form*/
/*		Var1–Varn, precede the list with the word "of"'.*/
/*		Arguments to the CALL SORTC routine cannot be constants. You may use*/
/*		array references as arguments to this routine as well.*/
/*Program 3.3: Demonstrating the CALL SORTC routine*/
DATA Names;
	INPUT (Name1-Name5)(: $12.);
	CALL SORTC(OF Name1-Name5);
DATALINES;
Charlie Able Hotel Golf Echo
Zemlachenko Cody Lane Lubsen Veneziale
bbb BBB aaa aaa ZZZ
;
RUN;
TITLE "Listing of data set NAMES";
PROC PRINT DATA = Names NOOBS;
RUN;
