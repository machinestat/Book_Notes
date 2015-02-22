---
Title: Using the MySQL Client Program
output: pdf_document
---

## 1.0 Introduction
The MySQL database system uses a client-server architecture. The server, _mysqld_, is the program that actually manipulates databases. To tell the server what to do, use a client program that communicates your intent by means of statements written in Structured Query Language(SQL). Client programs interacts with the server by connecting to it, sending SQL statements to have database operations performed, and receiving the results. Clients are installed locally on the machine from which you want to access MySQL, but the server can be installed anywhere.

The _mysql_ program is one of the clients included in MySQL distributions, and another one would be the graphical MySQL Workbench program, which provides a point-and-click interface to MySQL servers.

## 1.1 Setting Up a MySQL User Account
After we set up both MySQL clients and MySQL server, we need an account for connecting to the MySQL server. We can do this by connecting as he MySQL root user on the host where the server is running and issuing CREATE and GRANT statements to create a new MySQL account and give it database privileges.
```
% mysql -h localhost -u root p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 38
Server version: 5.5.41-0ubuntu0.14.04.1 (Ubuntu)

Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE USER 'cbuser'@'localhost' IDENTIFIED BY 'cbpass';
mysql> GRANT ALL ON cookbook.* TO 'cbuser'@'localhost';
Query OK, 0 rows affected (0.00 sec)
```
GRANT does not create database and we can give privileges for a databases before it exists.

The statements shown above are appropriate for connecting to MySQL from the same machine where the server is running. If we need to connect to the MySQL server from a host different from the one where the server is running, change _localhost_ to the name of the machine where we will be working.
```
mysql> CREATE USER 'cbuser'@'myhost.example.com' IDENTIFIED BY 'cbpass';
mysql> GRANT ALL ON cookbook.* TO 'cbuser'@'myhost.example.com';
```
Now we can verify the *cbuser* account.
```
% mysql -h localhost -u cbuser -p
Enter password: cbpass
```
If you want to see a list of users, use the following command:
```
mysql> select Host, User, Password from mysql.user;
+------------+------------------+-------------------------------------------+
| Host       | User             | Password                                  |
+------------+------------------+-------------------------------------------+
| localhost  | root             | *B6E7D9CB4385CA81E24FF70D5705954B78AD583B |
| shu-laptop | root             | *B6E7D9CB4385CA81E24FF70D5705954B78AD583B |
| 127.0.0.1  | root             | *B6E7D9CB4385CA81E24FF70D5705954B78AD583B |
| ::1        | root             | *B6E7D9CB4385CA81E24FF70D5705954B78AD583B |
| localhost  | debian-sys-maint | *344B39E0BEF5F6AD5B7B842711A7D6A730FFC508 |
| localhost  | cbuser           | *126CFB940B0843713B19A6C21B99C0F1F9F3AFB6 |
+------------+------------------+-------------------------------------------+
6 rows in set (0.00 sec)
```
And the protocol used for the connection from 127.0.0.1 is different from a connection from ::1.

## 1.2 Creating a Database and Tables
Now we want to create a database and set up tables within it, and we can use *CREATE DATABASE* statement to create a database after connecting the server using *mysql* client
```
mysql> CREATE DATABASE cookbook;
Query OK, 1 row affected (0.04 sec)
```
But even after creating the database we still do not have a default database:
```
mysql> SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| NULL       |
+------------+
```
So we need to select a default database;
```
mysql> USE cookbook;
Database changed
mysql> SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| cookbook   |
+------------+
```
We can also use the following command enables the user *cbuser* to connect to the *cookbook* database on the local host from command prompt.
```
>> mysql -p -u cbuser cookbook;
``





