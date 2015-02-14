---
output: pdf_document
---

# Fundamentals of MATLAB Programming

## Variables and constants in MATLAB
MATLAB variable names consist of a letter, followed by any number of letters, digits, or underscores.  

Reserved names for the constants.    
* eps -- error tolerance for flating-point operation  
 
* i and j -- If i or j is not overwritten, they both represent $\sqrt{-1}$

* Inf -- the MATLAB representation of infinity quantity $+\infty$

* NaN -- not a number, which is often returned by the operations 0/0, Inf/Inf and others.

* pi -- double-precision representation of the circumference ratio $\pi$

* lasterrr -- returns the error message received last time.

* lastwarn -- returns the last obtained warning message.

## Data structure
Double-precision data type  

To ensure high-precision computations, double-precision floating-point data type is used, which is 8 bytes(64 bits). It is composed of 11 exponential bits, 53 number bits and a sign bit, representing the data range of $\pm \times 10^{308}.

Symbolic data type

Before finding analytical solutions, the related variables should be declared as **symbolic**, with the **syms** statement `syms var_list var_props`, where _var\_list_ is the list of variables to be declared, separated by spaces. If necessary, the types of the properties of the varibles can be assinged by _var\_props_, such as $real$ or $positive$.

The varible precision arithmetic function vpa() can be used to display the symbolic variables in any precision. The syntax of the function is `vpa(A, n)` or `vpa(A)`, where A is the variable to be displayed, and n is the number of digits expected, with the default value of 32 decimal digits.

**_Example 1.1_** Display the first 300 digits of $\pi$.

Solution
```
>> vpa(pi, 300)
```