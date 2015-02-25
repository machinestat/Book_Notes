---
title: "Python Libraries"
output: pdf_document
---

**NumPy** is a fundamental Python library that provides numerical arrays and functions.

**SciPy** is a scientific Python library.

**matplotlib** is a plotting library based on NumPy.

**IPython** provides an architecture for interactive computing.

To install pakages on Debian or Ubuntu, we can use the following command:
```
$ sudo apt-get install python-packages
```

**Installing with setuptools**

If we have installed *setuptools* or *pip*, we can install, NumPy for example, with the following commands.
```
$ easy_install numpy
$ pip install numpy
```
**Building packages from source**

The source code can be retrieved with git or as an archive from GitHubm, and then install on /usr/locl with the following code from the source code directory:
```
$ git clone git://github.com/numpy/numpy.git numpy
$ python setup.py build
$ sudo python setup.py install --prefix=/usr/local
```

**A simple application**

Here we have a vector *a* holds the squares of integers 0 to n, and vector *b* holds the cubes of integers 0 to n; we want to add these two vectors.

The following function solves the vector addition problem using Python:
```
def pythonsum(n):
    a = range(n)
    b = range(n)
    c = []

    for i in range(len(a)):
        a[i] = i ** 2
        b[i] = i ** 3
        c.append(a[i] + b[i])

    return c

>>> pythonsum(5)
[0, 2, 12, 36, 80]
```

The following function solves the vector addition using NumPy:
```
def numpysum(n):
    import numpy
    a = numpy.arange(n) ** 2
    b = numpy.arange(n) ** 3
    c = a + b
    return c

>>> numpysum(5)
array([ 0,  2, 12, 36, 80])
```
*numpysum()* does not need for loop, and the *arange()* function from NumPy creates a NumPy array with integers from 0 to n.

