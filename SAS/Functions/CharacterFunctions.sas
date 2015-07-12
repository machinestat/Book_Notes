/*Storage Length for Character Variables*/
/*Program 1.1: How SAS determines storage lengths of character variables*/
DATA Example1;
	INPUT Group $ /*default length of 8;*/
	   @10 String $3.; *length is set to the informat width of 3;
	Left = 'x    '; *x and 4 blanks;
	Right = '    x'; *4 blanks and x;
	Sub = substr(Group, 1, 2); *equal length of Group;
	Rep = repeat(Group, 1); *default length of 200 for situation like this;
DATALINES;
ABCDEFGH 123
XXX        4
Y        5
;
RUN;
PROC PRINT DATA = Example1;
RUN;

/*Program 1.2: Running PROC CONTENTS to determine storage lengths*/
TITLE "PROC CONTENTS for Data Set EXAMPLE1";
PROC CONTENTS DATA = Example1 VARNUM;
RUN;

/*Functions That Change the Case of Characters*/
/*Function: UPCASE(character-value)*/
/*Purpose: to change all letters to uppercase*/
/*Program 1.3: Changing lowercase to uppercase for all character variables*/
/*in a data set.*/
DATA Mixed;
	LENGTH a b c d e $ 1;
	INPUT a b c d e x y;
DATALINES;
M f P p D 1 2
m f m F M 3 4
;
RUN;
DATA Upper;
	SET Mixed;
	ARRAY all_c[*] _CHARACTER_;
	DO I = 1 TO DIM(all_c);
		all_c[I] = UPCASE(all_c[I]);
	END;
	DROP I;
RUN;
TITLE "Listing of Data Set UPPER";
PROC PRINT DATA = Upper;
RUN;

/*Function: LOWCASE(character-value)*/
/*Purpose: to change all letters to lower case*/
/*Program 1.4: Program to demonstrate the LOWCASE function*/
DATA wt;
	INPUT ID : $3. Unit : $1. Weight;
	Unit = LOWCASE(Unit);
	IF Unit = "k" THEN Wt_lbs = 2.2 * Weight;
	ELSE IF Unit = "l" THEN Wt_lbs = Weight;
DATALINES;
001	k	100
002	K	101
003	L	201
004	l	166
;
TITLE "Listing of Data Set WT";
PROC PRINT DATA = wt NOOBS;
RUN;

/*Function: PROPCASE(character-value <,delimiters>)*/
/*Purpose: to capitalize the first letter of each word in a string.*/
/*<, delimiters> is an optional list of word delimiters. The default*/
/*delimiters are blank, forward slash, hyphen, open parenthesis, */
/*period and tab*/
/*Program 1.5: Capitalizing the first letter of each word in a string*/
DATA Proper;
	INPUT Name $60.;
	Name = PROPCASE(Name);
DATALINES;
ronald cODy
THomaS eDISON
albert einstein
;
TITLE "Listing of Data Set Proper";
PROC PRINT DATA = Proper NOOBS;
RUN;

/*Program 1.6: Program to capitalize the first letter of each word in a string*/
/*First and last name are two separate variables*/
DATA Proper;
	INFORMAT First Last $30.;
	INPUT First Last;
	LENGTH Name $ 60;
	Name = catx(' ', First, Last);
	Name = PROPCASE(Name);
DATALINES;
ronald cODy
THomaS eDISON
albert einstein
;
RUN;
TITLE "Listing of Data Set PROPER";
PROC PRINT DATA = Proper NOOBS;
RUN;

/*Functions that remove characters from string:*/
/*COMPBL (compress blanks) can replace multiple blanks with a single blank. The*/
/*CMPRESS function can remove not only blanks, but also any characters you specify*/
/*from a string.*/
/*Function: COMPBL(character-value)*/
/*Purpose: To replace all occurrences of two or more blanks with a sigle blank character.*/
/*Program 1.7: Using the COMPBL function to convert multiple blanks to a single blank.*/
DATA Squeeze;
	INPUT #1 @1  Name $20.
		  #2 @1  Address $30.
		  #3 @1  City $15.
		     @20 State $2.
			 @25 Zip $5.;
	Name = COMPBL(Name);
	Address = COMPBL(Address);
	City = COMPBL(City);
DATALINES;
Ron Cody
89 Lazy Brook Road
Flemington         NJ   08822
Bill     Brown
28   Cathy   Street
North   City       NY   11518
;
PROC PRINT DATA = Squeeze;
	ID Name;
	VAR Address City state Zip;
RUN;

/*Function: COMPRESS(character-value <, 'compress-list'> <, 'modifiers'>)*/
/*Purpose: To remove specified characters from a character value. When used with the k modifier,*/
/*         compress can be used to keep characters in a character value and remove everything else.*/
/*		 compress-list is an optional list of the characters you want to remove, the default */
/*		 character is a blank.*/
/*		 modifiers is an optional list of modifiers that refer to character classes:*/
/*		 	a	include all uppercase and lowercase letters.*/
/*			b	include all digits.*/
/*			s	include all spaces characters(blanks, horizontal and vertical tabs, carriage return,*/
/*				linefeed, and formdeed).*/
/*			i	ignore the case of characters.*/
/*			k	keep the characters listed in the compress-list or referenced by the modifiers instead of*/
/*				removing them.*/
/*			p	include all punctuation characters.*/
/*Program 1.8: Removing dashes and parentheses from phone numbers*/
DATA Phone_Number;
	INPUT Phone $ 1-15;
	Phone1 = COMPRESS(Phone);*only blanks are removed;
	Phone2 = COMPRESS(Phone, '(-) ');*remove left and right parentheses,dashes and blanks;
	Phone3 = COMPRESS(Phone,, 'kd');*keep all the digits;
DATALINES;
(908)235-4490
(201) 555-77 99
; 
TITLE "Listing of Data Set PHONE_NUMBER";
PROC PRINT DATA = Phone_Number;
RUN;

/*Program 1.9: Converting Social Security numbers from character to numeric*/
DATA Social;
	INPUT @1 SS_Char $11.
		  @1 Mike_Zdeb comma11.;*read social security number directly into a numeric variable;
		  SS_Numeric = INPUT(COMPRESS(SS_Char, '-'), 9.);
		  SS_Formatted = SS_Numeric;
		  FORMAT SS_Formatted ssn.;
DATALINES;
123-45-6789
001-11-1111
;
RUN;
TITLE "Listing of Data Set SOCIAL";
PROC PRINT DATA = Social NOOBS;
RUN;

/*Counting the Number of Digits in a Character String*/
/*This program computes the number of digits in a string by using the COMPRESS function to remove*/
/*all digits from the string and then substracts the resulting length from the original length for*/
/*the computation.*/
/*Program 1.10: Counting the number of digits in a string*/
DATA Count;
	INPUT String $20.;
	Only_letters = COMPRESS(String,,'d');
	Num_numerals = LENGTHN(String) - LENGTHN(Only_letters);
DATALINES;
ABC123XYZ
XXXXX
12345
1234X
;
RUN;
TITLE "Listing of Data Set COUNT";
PROC PRINT DATA = Count NOOBS;
RUN;

/*Functions That Search for Characters*/
/*Function: ANYALNUM*/
/*Purpose: To locate the first occurrence of an alphanumeric character*/
/*		 (any uppercase or lowercase letter or number) and return */
/*		 its position. If none is found, the function returns a 0.*/
/*		 With the use of an optional parameter , this function can */
/*		 begin search at any position in the string and can also*/
/*		 search from right to left.*/
/*Syntax: ANYALNUM(character-value <,start>)*/
/*		character-value is any SAS character value*/
/*		Start is an optional parameter that specifies the position in the string*/
/*		to begin the search. If it is omitted, the search starts at the beginning*/
/*		of the string. If it is non-zero, the search begins at the position in the*/
/*		string of the absolute value of the number(starting from the left-most*/
/*		position in the string). If the start value is positive, the search goes */
/*		from left to right; if the value is negative the search goes from right to*/
/*		left. A negative value larger than the length of the string results in a scan*/
/*		from right to left, starting at the end of the string. If the value of start */
/*		is a positive number longer than the length*/
/*		of the string, or if it is 0, the function returns 0.*/
/*Function: ANYALPHA*/
/*Purpose : To locate the first occurrence of an alpha character(any uppercase or*/
/*		  lowercase letter) and return its position.*/
/*Syntax:   ANYALPHA(character-value <, start>)*/
/*Function: ANYDIGIT*/
/*Purpose:  To locate the first occurrence of a digit(numeral) and return its position*/
/*Syntax:   ANYDIGIT(character-value <, start>)*/
/*Function: ANYPUNCT*/
/*Purpose:  To locate the first occurrence of a punctuation character and return its position*/
/*          In the ASCII character set, the following characters are considered punctuation"*/
/*		  ! " # $ % & ' ( ) * + , - . / : ;*/
/*		  < = > ? @ [ \ ] ^ _ ` { | } ~*/
/*Syntaxt: ANYPUNCT(character-value <, start>)*/
/*Function: ANYSPACE*/
/*Purpose:  To locate the first occurrence of a white space character(a blank, horizontal or*/
/*          vertical tab, carriage return, linefeed, and form-feed) and return its position*/
/*Function: ANYUPPER*/
/*Purpose:  To locate the first occurrence of an uppercase letter and return its position.*/
/*Syntax:   ANYUPPER(character-value <, start>)*/
/*Function: ANYLOWER*/
/*Purpose:  To locate the first occurrence of a lowercase letter and return its position.*/
/*Syntax:   ANYLOWER(character-value <, start>)*/
/*Program 1.11: Demonstrating the "ANY" character functions*/
DATA Anywhere;
	INPUT String $char20.;
	Alpha_num   = ANYALNUM(String);
	Alpha_num_9 = ANYALNUM(String, -999);
	Alpha       = ANYALPHA(String);
	Alpha_5     = ANYALPHA(String, -5);
	Digit       = ANYDIGIT(String);
	Digit_9     = ANYDIGIT(String, -999);
	Punct       = ANYPUNCT(String);
	Space       = ANYSPACE(String);
	Up          = ANYUPPER(String);
	Low         = ANYLOWER(String);
DATALINES;
Once upon a time 123
HELP!
987654321
UPPER and lower
;
RUN;
TITLE "Listing of Data Set ANYWHERE";
PROC PRINT DATA = Anywhere NOOBS HEADING = H;
RUN;
/*Program 1.12: Using the functions ANYDIGIT and ANYSPACE to find the first number in a string*/
/*This program identifies the first number in any line of data that contains a numeric value*/
/*(followed by one or more blanks)*/
DATA Search_Num;
	INPUT String $60.;
	Start = ANYDIGIT(String);
	End = ANYSPACE(String, Start);
	IF Start THEN
		Num = INPUT(SUBSTR(String, Start, End - Start), 9.);
DATALINES;
This line has a 56 in it
two numbers 123 and 456 in this line
No digits here
;
RUN;
TITLE "Listing of Data Set SEARCH_NUM";
PROC PRINT DATA = Search_Num NOOBS;
RUN;

/*The "Not" Functions*/
/*Function: NOTALNUM*/
/*Purpose: To determine the position of the first character in a string*/
/*         that is not an alphanumeric(any uppercase or lowercase letter */
/*		 or number) and return its position. If none is found, the */
/*		 function returns a 0. With the use of an optional parameter , */
/*		 this function can begin search at any position in the string */
/*         and can also search from right to left.*/
/*Syntax: NOTALNUM(character-value <,start>)*/
/*		character-value is any SAS character value*/
/*		Start is an optional parameter that specifies the position in the string*/
/*		to begin the search. If it is omitted, the search starts at the beginning*/
/*		of the string. If it is non-zero, the search begins at the position in the*/
/*		string of the absolute value of the number(starting from the left-most*/
/*		position in the string). If the start value is positive, the search goes */
/*		from left to right; if the value is negative the search goes from right to*/
/*		left. A negative value larger than the length of the string results in a scan*/
/*		from right to left, starting at the end of string. If the value of start */
/*		is a positive number longer than the length of the string, or if it is 0, */
/*		the function returns 0.*/
/*Function: NOTALPHA*/
/*Purpose : To determine the position of the first character in a string that is not an */
/*		  uppercase or lowercase letter(alpha character).*/
/*Syntax:   NOTALPHA(character-value <, start>)*/
/*Function: NOTDIGIT*/
/*Purpose:  To determine the position of the first character in a string that is not a digit.*/
/*Syntax:   NOTDIGIT(character-value <, start>)*/
/*Function: NOTUPPER*/
/*Purpose:  To determine the position of the first character in a string that is not an*/
/*		  uppercase letter.*/
/*Syntax:   NOTUPPER(character-value <, start>)*/
/*Function: NOTLOWER*/
/*Purpose:  To determine the position of the first character in a string that is not an*/
/*		  lowercase letter.*/
/*Syntax:   NOTLOWER(character-value <, start>)*/
/*Program 1.13: Demonstrating the "NOT" character functions*/
DATA Negative;
	INPUT String $5.;
	Not_alpha_numeric = NOTALNUM(String);
	Not_alpha         = NOTALPHA(String);
	Not_digit         = NOTDIGIT(String);
	Not_upper         = NOTUPPER(String);
	Not_lower         = NOTLOWER(String);
DATALINES;
ABCDE
abcde
abcDE
12345
:#$%&
;
RUN;
PROC PRINT DATA = Negative NOOBS;
	TITLE "Listing of Data Set Negative";
RUN;

/*FIND and INDEX both search a string for a given substring. However, the set of FIND functions has*/
/*the ablility to declare a starting position for the search, set the direction of the search, and*/
/*ignore case or trailing blanks.*/
/*Function:  FIND*/
/*Purpose: To loacte a substring within a string. With optional arguments, can define the starting*/
/*	     point for the search, set the direction of the search, and ignore case or trailing blanks.*/
/*Syntax: FIND(character-value, find-string <, 'modifiers'> <, start>)*/
/*	    character-value is any SAS character value.*/
/*		find-string is a character variable or string literal that contains one or more characters*/
/*		that you want to search for. The function returns the first position in the character-value*/
/*		that contains the find-string. If the find-string is not found, the function returns a 0.*/
/*		modifiers(in uppercase or lowercase) can be used with FIND:*/
/*			i	ignore case*/
/*			t	ignore trailing blanks in both the character variable and the find-string.*/
/*		start is an optional parameter that specifies the position in the string to begin the search.*/
/*		If it is omitted, the search starts at the beginning of the string. If it is non-zero, the */
/*		search begins at the position in the string of the absolute value of the number(starting */
/*		from the left-most position in the string). If the start value is positive, the search goes*/
/*		from left to right; if the value is negative, the search goes from right to left. A negative*/
/*		value larger than the length of the string results in a scan from right to left, starting at*/
/*		the end of the string. If the start is a positive number longer than the length of the string,*/
/*		or if it is 0, the function returns a 0.*/
DATA _NULL_;
	whereisshe = FIND('She sells seashells? Yes, she does.','she ');
	PUT whereisshe; *27;

	variable1='She sells seashells? Yes, she does.';
	variable2='she ';
	variable3='i';
	whereisshe_i=find(variable1,variable2,variable3);
	PUT whereisshe_i; *1;

	expression1='She sells seashells? '||'Yes, she does.';
	expression2=kscan('he or she',3)||'  ';
	expression3=trim('t   ');
	whereisshe_t=find(expression1,expression2,expression3);
	PUT whereisshe_t; *14;

	xyz='She sells seashells? Yes, she does.';
	startposvar=22;
	whereisshe_22=find(xyz,'she',startposvar);
	put whereisshe_22; *27;

	xyz='She sells seashells? Yes, she does.';
	startposexp=1-23;
	whereisShe_ineg22=find(xyz,'She','i',startposexp);
	put whereisShe_ineg22; *14;
RUN;

/*Program 1.14: Using the FIND and FINDC functions to search for strings*/
/*              and characters*/
DATA Find_Vowel;
    INPUT @1 String $20.;
    Pear = FIND(String, 'pear'); 
    Pos_vowel = FINDC(String, 'aeiou', 'i');
    Upper_vowel = FINDC(String, 'AEIOU');
    Not_vowel = FINDC(String, 'aeiou', 'ik'); /*ignore case, count only 
    characters not in the list*/
DATALINES;
XYZABCabc
XYZ
Apple and Pear
;
RUN;
TITLE "Listing of Data Set Find_Vowel";
PROC PRINT DATA =Find_Vowel NOOBS;
RUN;

/*Program 1.15: Converting numeric values of mixed units(e.g., kg and lbs)*/
/*              to a single numric quantity*/
DATA Heavy;
    INPUT Char_wt $ @@;
    Weight = INPUT(COMPRESS(Char_wt,,'kd'), 8.);
    IF FINDC(Char_wt, 'k', 'i') THEN Weight = 2.22 * Weight;
    Weight = ROUND(Weight);
DATALINES;
60KG 155 82KG 54kg 98
;
RUN;
TITLE "Listing of Data Set Heavy";
PROC PRINT DATA = Heavy NOOBS;
    VAR Char_wt Weight;
RUN;

/*Program 1.16: Searching for one of several characters in a character variable*/
DATA Check;
    INPUT Tag_Number $ @@;
    ***if the tag number contains an x, y, or z, it indicates
       an international destination otherwise, the destination
       is domestic;
    IF FINDC(Tag_Number, 'xyz', 'i') THEN
        Destination = 'International';
    ELSE Destination = 'Domestic';
DATALINES;
T123 ty333 1357z UZYX 888 ABC
;
RUN;
TITLE "Listing of Data Set Check";
PROC PRINT DATA = Check NOOBS;
    ID Tag_Number;
    VAR Destination;
RUN;

/*Program 1.17: Demonstrating the o modifier with FINDC*/
DATA o_modifier;
    INPUT String  $15.
          @16 Look_for $1.;
    Position = FINDC(String, Look_for, 'io');
DATALINES;
Capital A here A
Lower a here   X
Apple          B
;
RUN;
TITLE "Listing of Data Set o_modifier";
PROC PRINT DATA = o_modifier NOOBS heading = h;
RUN;

/*Function: FINDW*/
/*Purpose: To search a string for a word, defined as a group of letters separated on both ends by a word */
/*         boundary (a space, the beginning of a string, or the end of the string).*/
/*Syntax: FINDW(char-value, word <, delim>) or*/
/*        FINDW(char_value, word, delim, modifier<,start>)*/
/*Program 1.18: Searching for a word using the FINDW function*/
DATA Find_word;
    INPUT String $40.;
    Position_w = FINDW(String, "the");
    Position = FIND(String, "the");
DATALINES;
there is a the in this line
ends in the
ends in the.
none here
;
RUN;
TITLE "Listing of Data Set Find_Word";
PROC PRINT DATA = Find_Word;
RUN;

/*Function: INDEX*/
/*Purpose: To locate the starting position of a substring in a string.*/
/*Syntax: INDEX(character-value, find-string)*/
/**/
/*Function: INDEXC*/
/*Purpose: To search a character string for one or more characters. It can be used to search for any one in */
/*a list of character values.*/
/*Syntax: INDEXC(character-value, 'char1','char2','char3',...) OR*/
/*        INDEXC(character-value, 'char1char2char3. . .')*/
/*Program 1.19: Reading dates in a mixture of formats*/
DATA Mixed_Dates;
    INPUT @1 Dummy $15.;
    IF INDEXC(Dummy, '/-:') THEN Date = INPUT(Dummy, mmddyy10.);
    ELSE Date = INPUT(Dummy, date9.);
    FORMAT Date worddate.;
DATALINES;
10/21/1946
06JUN2002
5-10-1950
7:9:57
;
RUN;
TITLE "Listing of Data Set MIXED_DATES";
PROC PRINT DATA = Mixed_Dates NOOBS;
RUN;

/*Function: VERIFY*/
/*Purpose: To check whether a string contains any unwanted values.*/
/*Syntax: VERIFY(character-value, verify-string)*/
/*Program 1.20: Using the VERIFY function to check for invalid character data values*/
DATA Very_Fi;
    INPUT ID     $ 1-3
          Answer $ 5-9;
    P = VERIFY(Answer, 'ABCDE');
    OK = P EQ 0;
DATALINES;
001 ACBED
002 ABXDE
003 12CCE
004 ABC E
;
RUN;
TITLE "listing of Data Set VERY_FI";
PROC PRINT DATA = Very_Fi NOOBS;
RUN;

/*Functions That Extract Parts of Strings */
/*Function: SUBSTR*/
/*Purpose: To extract part of a string. When the SUBSTR function is used on the left side of the equal sign, */
/*it can place specified characters into an existing string.*/
/*Syntax: SUBSTR(character-value, start <,length>)*/
/*Program 1.21: Extracting portions of a character value and creating a character variable and a numeric value*/
DATA Substring;
    INPUT ID $ 1-9;
    LENGTH State $ 2;
    State = ID;
    Num = INPUT(SUBSTR(ID, 7), 3.);
DATALINES;
NYXXXX123
NJ1234567
;
RUN;
TITLE 'Listing of Data Set SUBSTRING';
PROC PRINT DATA = Substring NOOBS;
RUN;

/*Program 1.22: Extracting the last two characters from a string, regardless of the length*/
DATA Extract;
    INPUT @1 String $20.;
    Last_Two = SUBSTR(String, LENGTH(String) - 1);
DATALINES;
ABCDE
AX12345NY
126789
;
RUN;
TITLE "Listing of Data Set EXTRACT";
PROC PRINT DATA = Extract NOOBS;
RUN;

/*Program 1.23: Using the SUBSTR function to "unpack" a string*/
DATA Pack;
    INPUT String $ 1-5;
DATALINES;
12345
8 642
;
RUN;
DATA Unpack;
    SET Pack;
    ARRAY x[5];
    DO j = 1 TO 5;
        x[j] = INPUT(SUBSTR(String, j, 1), 1.);
    END;
    DROP j;
RUN;
TITLE "Listing of Data Set UNPACK";
PROC PRINT DATA = Unpack NOOBS;
RUN;

/*Function: SUBSTR (on the left-hand side of the equal sign)*/
/*Purpose: To place one or more characters into an existing string.*/
/*Syntax: SUBSTR(character-value, start <, length>) = character-value*/
/*Program 1.24: Demonstrating the SUBSTR function on the left-hand side of the equal sign*/
DATA Stars;
    INPUT SBP DBP @@;
    LENGTH SBP_chk DBP_chk $ 4;
    SBP_chk = PUT(SBP, 3.);
    DBP_chk = PUT(DBP, 3.);
    IF SBP GT 160 THEN SUBSTR(SBP_chk, 4, 1) = '*';
    IF DBP GT 90 THEN SUBSTR(DBP_chk, 4, 1) = '*';
DATALINES;
120 80 180 92 200 110
;
TITLE "Listing of data set STARS";
PROC PRINT DATA = Stars NOOBS;
RUN;

/*Function: SUBSTRN*/
/*Purpose: This function serves the same purpose as the SUBSTR function with a few added features.*/
/*         The starting position and the length arguments of the SUBSTRN function can be 0 or */
/*         negative withoutcausing an error. if the length is 0, the function returns a string of */
/*         0 length.*/
/*Syntax: SUBSTRN(character-value, start <, length>)*/
/*Program 1.25: Demonstrating the unique features of the SUBSTRN function*/
TITLE "Demonstring the SUBSTRN Function";
DATA Hoagie;
    String = 'abcdefghij';
    LENGTH Result $5.;
    Result = SUBSTRN(String, 2, 5);
    Sub1 = SUBSTRN(String, -1, 4);
    Sub2 = SUBSTRN(String, 3, 0);
    Sub3 = SUBSTRN(String, 7, 5);
    Sub4 = SUBSTRN(String, 0, 2);
    FILE PRINT;
    PUT "Original string =" @25 String /
         "Substrn(string,2,5) =" @25 Result /
         "Substrn(string,-1,4) =" @25 Sub1 /
         "Substrn(string,3,0) =" @25 Sub2 /
         "Substrn(string,7,5) =" @25 Sub3 /
         "Substrn(string,0,2) =" @25 Sub4;
RUN;

/*Function: CHAR*/
/*Purpose: To extract a single character from a string. The default length of the result is 1 byte.*/
/*Syntax: CHAR(character-value, position)*/
/*Program 1.26: Demonstrating the CHAR function*/
***Other functions: LENGTHC;
DATA Char;
    String = "ABC123";
    First = CHAR(String, 1);
    Length = LENGTHC(First);
    Second = CHAR(String, 2);
    Beyond = CHAR(String, 9);
    L_Beyond = LENGTHC(Beyond);
RUN;
TITLE "Demonstrating the CHAR Function";
PROC PRINT DATA = Char NOOBS;
RUN;

/*Function: FIRST*/
/*Purpose: To extract the first character from a string.*/
/*Syntax: FIRST(character-value)*/
/*Program 1.27: Demonstrating the FIRST function*/
DATA Names;
    INPUT (First Middle Last)(: $10.);
    Initials = FIRST(First) || FIRST(Middle) || FIRST(Last);
DATALINES;
Brian Page Watson
Sarah Ellen Washington
Nelson W. Edwards
;
RUN;
TITLE "Listing of data set NAMES";
PROC PRINT DATA = Names NOOBS;
RUN;

/*Functions That Join Two or More Strings Together*/
/*Function: CALL CATS*/
/*Purpose: To concatenate two or more strings, removing both leading and trailing blanks before the */
/*         concatenation takes place.*/
/*Syntax: CALL CATS(result, string-1 <,string-n>)*/

/*Function: CALL CATT */
/*Purpose: To concatenate two or more strings, removing only trailing blanks before the concatenation */
/*         takes place.*/
/*Syntax: CALL CATT(result, string-1 <,string-n>)*/

/*Function: CALL CATX*/
/*Purpose: To concatenate two or more strings, removing both leading and trailing blanks before the */
/*         concatenation takes place, and place a single space, or one or more characters of your */
/*         choice, between each of the strings.*/
/*Syntax: CALL CATX(separator, result, string-1 <,string-n>)*/
/*Program 1.28: Demonstrating the three concatenation CALL routines*/
DATA Call_Cat;
    String1 = "ABC"; * no spaces;
    String2 = "DEF   "; * three trailing spaces;
    String3 = "   GHI"; * three leading spaces;
    String4 = "   JKL   "; *three leading and trailing spaces;
    LENGTH Result1 - Result4 $ 20;
    CALL CATS(Result1, String2, String4); *DEFJKL;
    CALL CATT(Result2, String2, String1); *DEFABC;
    CALL CATX(" ", Result3, String1, String3); *ABC GHI;
    CALL CATX(",", Result4, String3, String4); *GHI,JKL;
RUN;
TITLE "Listing of Data Set CALL_CAT";
PROC PRINT DATA = Call_Cat NOOBS;
RUN;

/*The "CAT" Functions (CAT, CATS, CATT, CATX, and CATQ)*/
/*Function: CAT*/
/*Purpose: To concatenate (join) two or more character strings or numeric values, leaving leading and/or */
/*         trailing blanks unchanged.*/
/*Syntax: CAT(item-1, item-2 <,item-n>)*/
/**/
/*Function: CATS*/
/*Purpose: To concatenate (join) two or more character strings or numeric values, stripping both leading and */
/*         trailing blanks on character values.*/
/*Syntax: CATS(item-1, item-2 <,item-n>)*/
/**/
/*Function: CATT*/
/*Purpose: To concatenate (join) two or more character strings or numeric values, stripping only trailing */
/*         blanks on character values.*/
/*Syntax: CATT(item-1, item-2 <,item-n>)*/
/**/
/*Function: CATX*/
/*Purpose: To concatenate (join) two or more character strings or numeric values, stripping both leading and */
/*         trailing blanks on character values and inserting one or more separator characters between the strings.*/
/*Syntax: CATX(separator, item-1, item-2 <,item-n>)*/
/**/
/*Function: CATQ*/
/*Purpose: This function is similar to the CATX function. Unlike CATX, CATQ does not automatically strip */
/*         leading and trailing blanks unless you use the s modifier. In addition, with the a modifier, you */
/*         can place quotes around all of the concatenated strings. As with the other "CAT" functions, the */
/*         arguments can be character or numeric.*/
/*Syntax: CATQ(modifiers,<delimiter,>,item-1,item-2 <,item-n>)*/
/*The following modifiers, placed in single or double quotation marks, can be used with CATQ:*/
/*        a   place quotes around each of the strings to be concatenated.*/
/*        1   use single quotes.*/
/*        2   use double quotes.*/
/*        d   treat the next argument as a delimiter.*/
/*        s   strip leading and trailing quotes.*/
/*        m   add delimiters after the first item, even if the item is a missing value.*/
/*Program 1.29: Demonstrating the five concatenation functions*/
TITLE "Demonstrating the CAT functions";
DATA _NULL_;
    FILE PRINT;
    String1 = "ABC"; * no spaces;
    String2 = "DEF   "; * three trailing spaces;
    String3 = "   GHI"; * three leading spaces;
    String4 = "   JKL   "; * three leading and trailing spaces;
    LENGTH Join1 - Join10 $ 20;
    Join1 = CAT(String2,String3); *DEF   GHI;
    Join2 = CATS(String2,String4); *DEFJKL;
    Join3 = CATS(12,34,56); *123456;
    Join4 = CATT(String2,String1); *DEFABC;
    Join5 = CATX(" ",String1,String3); *ABC GHI;
    Join6 = CATX(",",String3,String4); *GHI,JKL;
    Join7 = CATX("-",908,782,6562); * 908-782-6562;
    Join8 = CATQ(" ",String1,String3); *ABC    GHI   ;
    Join9 = CATQ("a",String1,String3); *"ABC""   GHI   ";
    Join10 = CATQ("as",String1,String3); *"ABC""GHI";
    S1 = ':' || String1 || ':';
    S2 = ':' || String2 || ':';
    S3 = ':' || String3 || ':';
    S4 = ':' || String4 || ':';
    PUT /"String 1 " S1/
         "String 2 " S2/
         "String 3 " S3/
         "String 4 " S4/
        Join1= /
        Join2= /
        Join3= /
        Join4= /
        Join5= /
        Join6= /
        Join7= /
        Join8= /
        Join9= /
        Join10= / ;
RUN;
