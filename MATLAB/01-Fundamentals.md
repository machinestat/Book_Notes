---
output: pdf_document
title: Fundamentals of MATLAB Programming
---

## 1.1 Variables and constants in MATLAB
MATLAB variable names consist of a letter, followed by any number of letters, digits, or underscores.  

Reserved names for the constants.    
* eps -- error tolerance for flating-point operation  
 
* i and j -- if i or j is not overwritten, they both represent $\sqrt{-1}$

* Inf -- the MATLAB representation of infinity quantity $+\infty$

* NaN -- not a number, which is often returned by the operations 0/0, Inf/Inf and others.

* pi -- double-precision representation of the circumference ratio $\pi$

* lasterrr -- returns the error message received last time.

* lastwarn -- returns the last obtained warning message.

## 1.2 Data structure
**Double-precision data type**

To ensure high-precision computations, double-precision floating-point data type is used, which is 8 bytes(64 bits). It is composed of 11 exponential bits, 53 number bits and a sign bit, representing the data range of $\pm \times 10^{308}$.

**Symbolic data type**

Before finding analytical solutions, the related variables should be declared as **symbolic**, with the **syms** statement `syms var_list var_props`, where _var\_list_ is the list of variables to be declared, separated by spaces. If necessary, the types of the properties of the varibles can be assinged by _var\_props_, such as **real** or **positive**.

The varible precision arithmetic function vpa() can be used to display the symbolic variables in any precision. The syntax of the function is `vpa(A, n)` or `vpa(A)`, where A is the variable to be displayed, and n is the number of digits expected, with the default value of 32 decimal digits.

**_Example 1.1_** Display the first 300 digits of $\pi$.

**_Solution_**
```
>> vpa(pi, 300)
```

**Other data types**

(i) **Strings**  String variables are used to store messages.

(ii) **Multi-dimensional arrays** 

(ii) **Cell arrays** Cells are extension of matrices, whose elements are no longer values. The element, referred as _cells_, of cell arrays can be of any data type.

(iii) **Classes and objects** 

## 1.3 Basic structure of MATLAB

Two types of MATLAB statements can be used:

(i) **Direct assignment** The basic structure of this type of statement is 
```
variable = expresion
```
and expression can be evalued and assigned to the variable defined in the left-hand-side, and established in MATLAB worksapce. The semicolon can be used to suppress the display of intermediate results, and the reserved variable **ans** always stores the latest statement without a left-hand-side variable.

**_Example 1.2_** Specify the matrix $A = \begin{bmatrix}
 1 & 2 & 3 \\ 
 4 & 5 & 6 \\ 
 7 & 8 & 0
\end{bmatrix}$ into MATLAB workspace.

**_Solution_** 
```
>> A = [1,2,3; 4,5,6; 7,8,0]
```

The size of a matrix can be expanded or reduced dynamically, with the following statemensts.
```
>> A = [1,2,3; 4,5,6; 7,8,0];     % assignment is made, however no display
   A = [[A; [1 2 3]], [1;2;3;4]]  % dynamically define the size of matrix
```

**_Example 1.3_** Enter complex matrix $B = \begin{bmatrix}
 1+j9 & 2+j8 & 3+j7 \\ 
 4+j6 & 5+j5 & 6+j4 \\ 
 7+j3 & 8+j2 & 0+j1
\end{bmatrix}$ into MATLAB.

**_Solution_** The notations i and j can be used to describe the imaginary unit.
```
B=[1+9j,2+8j,3+7j; 4+6j 5+5j,6+4j; 7+3j,8+2j 0+1j]
```
(ii) **Function call statement**  The basic statement structure of function call is   
    $[returned\_arguments] = function\_name(input\_arguments)$    
Generally the function names are the file names in the MATLAB path.

## 1.4 Colon expressions and sub-matrices extration
Colon expression is an effective way in defining **row vectors**. The typical form of colon expression is `v = s1:s2:s3`. Thus a row vector **v** can be established in MATLAB workspace, with the initial value _s1_, the increment _s2_ and the final value _s3_. The default value for increment is 1.   

**_Example 1.4_** For different increments, establish vectors for $t \in \left [ 0, \pi \right ]$   
**_Solution_** 
```
>> v1 = 0 : 0.2 : pi    % row vector from 0 to 3 with step of 0.2

>> v2 = 0 : -0.1 : pi   % negative step, no vector generated
   v3 = 0 : pi          % with the default step of 1
   v4 = pi : -1 : 0     % a vector in the reverse order of v1
```
The sub-matrix of a given matrix A can be extracted with B = A(_v1_, _v2_), where _v1_ vector contains the numbers in the rows, and _v2_ contains the numbers of columns. If _v1_ is assigned to :, all the columns can be extracted. The keyword *end* can be used to indicated the last row or column.

**_Example 2.5_** Extract different sub-matrices from the given matrix **A**.
```
>> A = [1,2,3; 4,5,6; 7,8,0];
   B1 = A(1:2:end, :)	 	  % extract all the odd rows of matrix A  
   B2 = A([3,2,1], [1 1 1])  % copy the reversed first column to all columns 
   B3 = A(:, end:-1:1)       % flip left-right the given matrix A
```
and the sub-matrices are:$B1 = \begin{bmatrix}
 1 & 2 & 3 \\ 
 7 & 8 & 0 \\ 
\end{bmatrix}$, $B2 = \begin{bmatrix}
 7 & 7 & 7 \\ 
 4 & 4 & 4 \\ 
 1 & 1 & 1
\end{bmatrix}$, $B3 = \begin{bmatrix}
 3 & 2 & 1 \\ 
 6 & 5 & 4 \\ 
 0 & 8 & 7
\end{bmatrix}$

## 2.1 Algebraic operations of matrices
The following algebraic operations can be defined:

(i) **Matrix transpose** For an _n_ $\times$ _m_ matrix **A**, the transpose matrix **B** can be defined as $b_{ji} = a_{ij}, i = 1,..., n, j = 1,...,m$, thus **B** is an _m_ $\times$ _n_ matrix. The transpose can be obtained with $A_{.}^{'}$, which is the same as $A^{,}$.

(ii) **Addition and subtraction** Assume that there are two matrices *A* and *B* in MATLAB workspace, teh statements `C = A + B` and `C = A - B` can be used respectively to evaluate the addition and subtraction of these two matrices.

(iii) **Matrix multiplication** Assume that matrix **A** of size _n_ $\times$ _m_ and matrix **B** of size _m_ $\times$ _r_ are two variables in MATLAB workspace, and the columns of **A** equal the rows of **B**, the two matrices are referred to a _comptible_ . If two matrices are compatible, the multiplication of the two matrices can be obtained with `C = A*B` in MATLAB.

(iv) **Matrix left division** The left division of the matrices `A\B` can be used to solve the linear equations **_AX = B_**. If matrix **A** is non-singular, then **_X = $A^{-1}$B_**. If **A** is not a square matrix, `A\B` can also be used to find the least squares solution to the equations **_AX = B_**.

(v) **Matrix right division** The statement $B/A ={\left ( {A}'\setminus {B}' \right )}'$. can be used to solve the linear equations **_XA = B_**.

(vi) **Matrix flip and rotation** The left-right flip and up-down flip of a given matrix **_A_** can be obtained with `B=fliplr(A)` and `C=flipup(A)` respectively. The command `D = rot90(A)` rotates matrix **A** counterclockwise by $90^{0}$.

(vii) **Matrix power** $A^{x}$ computes the matrix **A** to the power x when matrix **A** is square. In MATLAB, the power can be evaluated with `F = A^x`.

(viii) **Dot operation** The statement `C = A.*B` can be used to obtain element-by-element product of matrices *A* and *B*, such that $c_{ij} = a_{ij}b_{ij}. The dot product is also referred to as the _Hadamard product_.

## 2.2 Logic operations of matrices
Assume that the matrices *A* and *B* are both $n \times m$ matrices, the following operations are defined:

(i) **"And" operation** In MATLAB, the operator & is used to define element-by-element "and" operation. The statement *A & B* can then be defined.

(ii) **"Or" operation** In MATLAB, the operator | is used to define element-by-element operation: *A | B*.

(iii) **"Not"** operation In MATLAB, the operator ~ can be used to define the "not" operation such that *B = ~A*.

(iv) **Exclusive or** The exclusive or operation of two matrices *A* and *B* can be evaluated from *xor(A, B)*.

## 2.3 Relationship operations of matrices
*C = A > B* performs element-by-element comparison, with the element $c_{ij} = 1$ for $a_{ij} > b_{ij}, and c_{ij} = 0$ otherwise. The equality relationship can be tested with == operator, while the other operators >=, ~= can also be used. *find()* and *all()* can also be used to perform relationship operations. 

```
>> A = [1,2,3; 4,5,6; 7,8,0];%enter a matrix
>> i = find(A >= 5) %find all the indices in A whose value if larger than 5
i =
     3
     5
     6
     8
```
The function arranges first the original matrix *A* in a single column, on a columnwise basis. The indices can then be returned.

The functions *all()* and *any()* can also be used to check the values in the given matrices.
```
>> a1 = all(A >= 5) %check each column whether all larger than 5
a1 =
     0     0     0
>> a2 = any(A >= 5) %check each column whether any larger than 5
a2 =
     1     1     1
```

## 2.4 Simplifications and presentations of anlaytical results
The Symbolic Math Toolbox can be used to derive mathematical formulas. The results however are often not presented in their simplest form. The results should then be simplified. The easiest way of simplicifcation is by the use of *simple()* function, where different simplification methods are tested automatically until the simplest result can be obtained, with the syntaxes 
```
s1 = simple(s), % try various simplification methods and find the simplest  
[s1, how] = simple(s), % return the simplest form and the method used
```

where *s* is the original expression, and *s1* is the simplified result. The string argument *how* will return the method of simplification. Apart from the easy-to-use *simple()* function, the function *collect()* can be used to collect the coeffiecients, and function *expand()* can be used to expand a polynomial. The function *factor()* can be used to perform factorization of a polynomial. The function *numden()* can be used to extract the numerator and enominator from a given expression.

**Example 2.7** If a polynomial *P(s)* is given by $P(s) = \left(s + 3\right)^{2}\left(s^{2}+3s+2\right)\left(s^{3}+12s^{2}+48s+64\right )$, process it with various functions and understand the results

**Solution** Asymbolic variable `s` should be declared first, then the full polynomial can be expressed easily and the polynomial can then be established in MATLAB

```
>> syms s;
>> P = (s + 3)^2*(s^2 + 3*s + 2)*(s^3 + 12*s^2 + 48*s + 64);
>> [P1, m] = simple(P)
P1 =
(s + 3)^2*(s + 4)^3*(s^2 + 3*s + 2)
m =
simplify
```

a series of simplications made, find the simplest and one finds that finds that $P_{1} = \left(s + 3\right)^{2}*\left(s + 2\right)*\left(s + 1 \right)*\left(s + 4\right)^{3}$, with the method m = *factor*, which means that factorization method is used reach the coclusion. Also expand() can be tested
```
>> expand(P)  %expand the polynomial
ans =
s^7 + 21*s^6 + 185*s^5 + 883*s^4 + 2454*s^3 + 3944*s^2 + 3360*s + 1152
```

The function `subs()` provided in the Symbolic Math Toolbox can be used to perform variable substitution, and the syntaxes are
$f_{1}=subs\left(f, x_{1}, x_{1}^{*}\right)$ or $f1 = subs\left(f,\left\{x_{1},x_{2},\cdots ,x_{n}\right\}, \left\{x_{1}^{*},x_{2}^{*},\cdots,x_{n}^{*}\right\}\right)$   
where f is the original expression. With the statement, the variable $x_{1}$ in the original function can be substituted with a new variable or expression $x_{1}^{2}$. The result is given in the variable $f_{1}$. The latter syntax can be used to substitue many variable simultaneously.


**Example 2.8** For a given function $f\left(t\right)=cos\left(at +b\right)+sin\left(ct\right)sin\left(dt\right)$, evaluate its Taylor expression with the function *taylor()*.  
```
>> syms a b c d t;      %declare symbolic variables
>> f = cos(a*t + b) + sin(c*t)*sin(d*t) %declare the function f(t) with taylor();
f =
cos(b + a*t) + sin(c*t)*sin(d*t)
>> f1=taylor(f)
f1 =
cos(b) - t^4*((c^3*d)/6 + (c*d^3)/6 - (a^4*cos(b))/24) + t^2*(c*d - (a^2*cos(b))/2) - a*t*sin(b) + (a^3*t^3*sin(b))/6 - (a^5*t^5*sin(b))/120
```




