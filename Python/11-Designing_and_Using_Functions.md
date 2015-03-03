---
title: "Designing and Using Functions"
output: pdf_document
---

## 1.1 Functions That Python Provides
The general form of a function call is as follows:
`<<function_name>>(<<arguments>>)`

An _argument_ is an expression that appears between the parentheses of a function call. For example, when we use the built-in function _abs_ : `abs(-9)`, the argument is -9.

Here, we calculate the difference between a day temperature and a night temperature, using Python IDLE:
```
Python 3.4.0 (v3.4.0:04f714765c13, Mar 16 2014, 19:24:06) [MSC v.1600 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> day_temperature = 3
>>> night_temperature = 10
>>> abs(day_temperature - night_temperature)
7
```

In this call on function `abs`, the argument is `day_temperarue - night_temperature`. Python evaluates this expression to -7. This value is _passed_ to function `abs`, which then _returns_, or produces, the value 7.

Here are the rules to executing a function call:

1. Evaluate each argument one at a time, working from left to right.
2. Pass the resulting values into the function.
3. Execute the function. When the function call finishes, it produces a value.

Because function calls produce values, they can be used in expressions:
```
>>> abs(-7) + abs(3.3)
10.3
```

We can also use function calls as arguments to other functions:
```
>>> pow(abs(-2), round(4.3))
16
```
Python sees the call on `pow` and starts by evaluating the arguments from left to right. The first argument is a call on function `abs`, so Python executes it. `abs(-2)` produces 2, so that's the first value for the call on `pow`. Then Python executes `round(4.3)`, which produces 4.

Now that the arguments to the call on function `pow` have been evaluated, Python finishes calling `pow`, sending in 2 and 4 as the argument values. That means that `pow(abs(-2), round(4.3))` is equivalent to `pow(2, 4)`, and $2^{4}$ is 16.

Some of the most useful built-in functions are ones that convert from one type to another.
```
>>> int(-4.3)
-4
>>> float(21)
21.0
```

So when a floating-point number is converted to an integer, it is truncated, not rounded.

## 1.2 Memory Addresses
Python keeps track of each value in a separate object and each object has memory address. We can find the actual memory address of an object using built-in function `id`:
```
>>> help(id)
Help on built-in function id in module builtins:

id(...)
    id(object) -> integer
    
    Return the identity of an object.  This is guaranteed to be unique among
    simultaneously existing objects.  (Hint: it's the object's memory address.)

>>> id(-9)
47569920
>>> fahrenheit = 82
>>> id(fahrenheit)
500220600
# Function objects also have memory address:
>>> id(abs)
1448976
```

## 1.3 Defining Our Own Functions
We want to create functions that can do what we want. For example, we may want to use a function that can convert temperature from Farhenheit to Celsius.

A function definition is a kind of Python statement. The general form of a function definition is as follows:
```
def <<function_name>>(<<parameters>>):
    <<block>>
    return <<expression>>
```
The function header (The first line of the function definition) starts with `def`, followed by the name of the function, then a comma-separated list of _parameters_ within parentheses, and then a colon. A parameter is a variable.

Below the function header and indented(four spaces) is a block of statements called the _function body_. the function body must contain at least one statement.

Most function definitions will include a `return` statement that, when executed, ends the function and produces a value as the result of the function call.

## 1.4 Using Local Variables for Temporary Storage

Variables that are created within a function are called _local variables_. Local variables get created each time that function is called, and they are erased when the function returns. Because they only exist when the function is being executed, they can't be used outside of the function.

A function's parameters are also local variables, so we get error if we try to use them outside of a function.

The area of a program that a variable can be used in is called the varialbe's _scope_. The scope of a local variable is from the line in which it is defined up until the end of the function.

## 1.5 Designing New Functions
This section describes a step-by-step recipe for designing and writing a function. Part of the outcome will be a working function, but almost as important is the _documentation_ for the function. Python uses three double quotes to start and end this documentation; everything in between is meant for humans to read. This notation is called a _docstring_, which is short for _documentation string_.

Here is an example of a completed function using a function reciepe(FDR).

```
>>> def days_difference(day1, day2):
	""" (int, int) -> int

	Return the number of days between day1 and day2, which are
	both in the range 1-365 (thus indicating the day of the
	year).

	>>> days_difference(200, 224)
	24
	>>> days_difference(50, 50)
	0
	>>> days_difference(100, 99)
	1
	"""
	return day2 - day1
```

Here are the parts of the function, including the docstring:

  * The first line is the function header.
  * The second line has three double quotes to start the docstring. The (int, int) part describes the types of values expected to  be passed to parameters day1 and day2, and the int after the -> is the type of value the function will return.
  * Ater that is a description of what the function will do when it is called. It mentions both parameters and describes what the function returns.
  * Next are some example calls and return values as we would expect to see in the Python sell.
  * The last line is the body of the function.

There are six steps to the function design recipe.

  1. *Examples* The first step is to figure out what arguments you want to give to your function and what information it will return: this name is often a short answer to the question, "What does your function do?" Type a couple of example calls and return values.

Before we write *anything*, we need to decide what information we have (the argument values) and what information we want the function to produce (the return value). Here are the examples from *days_diference*:
```
>>> days_difference(200, 224)
24
>>> days_difference(50, 50)
0
>>> days_difference(100, 90)
-1
```

  2. *Type Contract* The second step is to figure out the types of information your function will handle and what type of value is returned. This is called a *contract* because we are claiming that if you call this function with the right types of values, we will give you back the right type of values. Here is the type contract from *days_difference*:
```
	""" (int, int) -> int

```

  3. *Header* Write the function header. Pick meaningful parameter names to understand what information to
give to your function. Here is the header from *days_difference*:
```
>>> def days_difference(day1, day2):

```

  4. *Description* Write a short paragraph describing your function. Mention every parameter in your description and describe the return value. Here is the description from *days_difference*:
```
... Return the number of days between day1 and day2, which are
... both in the range 1-365 (thus indicating the day of the
... year).
```

  5. *Body* By now, you should have a good idea of what you need to do in order to get your function to behave properly. It’s time to write some code! Here is the body from *days_difference*:
```
... return day2 - day1
```

  6. *Test* Run the examples to make sure the function boday is correct.

**Designing Three Birthday-Related Functions**
We want to solve this problem: Which day of the week will a birthday fall upon, given what day of the week it is today and what day of the year the birthday is on? For example, if today is the third day of the year and it’s a Thursday, and a birthday is on the 116th day of the year, what day of the week will it be on that birthday?

We’ll design three functions that together will help us do this calculation. we’ll need to put functions that we write in the same file if we want to be able to have them call one another.

We will represent the day of the week using 1 for Sunday, 2 for Monday, and so on:


|Day of the Week|Number|
|:--------------|:-----|
|Sunday         |1     |
|Monday         |2     |
|Tuesday        |3     |
|Wednesday      |4     |
|Thursday       |5     |
|Friday         |6     |
|Saturday       |7     |

We will also ignore months and use the numbers 1 through 365 to indicate the day of the year. For example, we’ll represent February 1st as 32, since it’s the thirty-second day of the year.   

**How Many Days Difference?**

We’ll start by function *days_difference*. Here are the function design recipe steps.

  1. *Examples* We want a clear name for the difference in days; we’ll use *days_difference*. In our examples, we want to call this function and state what it returns. If we want to know how many days there are between the 200th day of the year and the 224th day:  
```
>>> days_difference(200, 224)
24
```

What if the two days are the same? How about if the second one is before the first?
```
>>> days_difference(50, 50)
0
>>> days_difference(100, 99)
-1
```

  2. *Type contract* The arguments in our function call examples are all integers, and the return values are integers too, so here’s our type contract:
```
(int, int) -> int
```

  3. *Header* We can now write the header. Both arguments are day numbers, so we’ll use day1 and day2:
```
def days_difference(day1, day2):
```

  4. *Desription* We’ll now describe what a call on the function will do.
```
Return the number of days between day1 and day2, which are both in the range 1-365 (thus indicating a day of the year).
```

  5. *Body* Here is the whole function again, including the body:
```
>>> def days_difference(day1, day2):
... """ (int, int) -> int
...
... Return the number of days between day1 and day2, which are
... both in the range 1-365 (thus indicating the day of the
... year).
...
... >>> days_difference(200, 224)
... 24
... >>> days_difference(50, 50)
... 0
... >>> days_difference(100, 99)
... -1
... """
... return day2 - day1
...
```

  6. *Test* Test the function, checking that we get back what we expect:
```
>>> days_difference(200, 224)
24
>>> days_difference(50, 50)
0
>>> days_difference(100, 99)
-1
```



