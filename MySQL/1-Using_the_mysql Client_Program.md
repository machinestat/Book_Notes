---
Title: Using the MySQL Client Program
output: pdf_document
---

## 1.0 Introduction
The MySQL database system uses a client-server architecture. The server, _mysqld_, is the program that actually manipulates databases. To tell the server what to do, use a client program that communicates your intent by means of statements written in Structured Query Language(SQL). Client programs interacts with the server by connecting to it, sending SQL statements to have database operations performed, and receiving the results. Clients are installed locally on the machine from which you want to access MySQL, but the server can be installed anywhere.

The _mysql_ program is one of the clients included in MySQL distributions, and another one would be the graphical MySQL Workbench program, which provides a point-and-click interface to MySQL servers.



