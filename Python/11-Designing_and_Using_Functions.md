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

