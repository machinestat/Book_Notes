---
Title: XML Data
output: html_document
---

## Introduction, Well-formed XML

### Extensible Markup Laguage(XML)  
* Standard for data representation and exchange
* Document format similar to HTML
  * Tags describe content instead of formatting
* Also streaming format

### Basic constructs

* Tagged elements(nested)
* Attributes
* Text

### Relational Model versus XML

|                | Relational          | XML                        |
| ---------------|:-------------------:| --------------------------:|
|   Structure    |  Tables             |Hierarchical Tree           |
|   Schema       |Fixed in advance     |Flexible "self-describing"  |
|   Queries      |Simple, nice language|Less so                     |
|   Ordering     |None                 |Implied ordering            |
| Implementation | Native              |Add-on                      |

Example 1: You are creating a database to contain information about university records: students, courses, grades, etc. Should you use the relational model or XML?

Answer: The database has a simple structure fixed in advance, so it's amenable to the relaitional model. 

Example 2: You're creating a database to contain information for a university web site: news, academic announcements, admissions, events, research, etc. Should you use the relational model or XML?

Answer: The database has a fixed structure suggesting relational, but it's strictly hierarchical suggesting XML. Either may be suitable.

Exmaple 3: You are creating a database to contain information about family trees(ancestry). Should you use the relatinal or XML

Answer: The database has a fixed structure suggesting relational, but it's strictly hierarchical suggesting XML. Either may be suitable.

### "Well-Formed" XML
Adheres to basic structural requirements
* Single root element
* Matched tags, proper nesting
* Unique attributes within elements

### Displaying XML
Use rule-based language to translate to HTML
* Cascading stylesheets (CSS)
* Extensible stleshee language (XSL)

## XML Data DTDs, IDs & IDREFs

### "Valid" XML
Adheres to basic structural requirements. Also adheres to content-specific specification
* Document Type Descriptor (DTD)
* XML Schema (XSD)

### Document Type Descriptor (DTD)
* Grammer-like language for specifying elements, attributes, nesting, ordering, #occurrences
* Also special attribute types ID and IDREF(S)


