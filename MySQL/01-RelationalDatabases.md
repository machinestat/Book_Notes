---
title: "Relational Databases"
output: pdf_document
---

## The Relational Model
* Used by all major commercial database systems
* Very simple model
* Query with high-level languages: simple yet expressive
* Efficient implementations

### Database = set of named **relations** (or **tables**)
Each relation has a set of named **attributes**(or **columns**)
Each **tuple** (or **row**) has a value for each attribute
Each attribute has a **type** (or **domain**)

**Schema**--structural desription of relations in database
**Instance**--actual contents at given point in time
**NULL**--special value for "unknown" or "undefined"
**Key**--attribute whose value is unique in each tuple   
Or set of attributes whose combined values are unique

### Creatng relations (tables) in SQL
```
Create Table Student(ID, name, GPA, photo)

Create Table College
	(name string, state char(2), enrollment integer)
```

## Querying Relational Databases

### Steps in creating and using a (relational) database

1. Design schema; create using DDL
2. "Bulk load" initial data
3. Repeat: execute queries and modifications

### Relational databases support Ad-hoc queries in high-level language
* Some easy to pose; some a bit harder
* Some easy for DBMS to execute efficiently; some harder
* "Query language" also used to modify data

### Queries return relations("compositional", "closed")

### Query Languages
* Relational Algebra--a formal language

* SQL-- actual/implemented languages

example:  
IDs of students with GPA > 3.7 applying to Standord

Relational Algebra:   
$\pi_{ID}\sigma_{GPA > 3 \Lambda CName ='Standford'}\left ( Student \infty Apply \right )$
SQL:  
```
Select Student.ID  
From Student, Apply  
where Student.ID = Apply.ID
And GPA > 3.7 and college = 'Standford'
```
