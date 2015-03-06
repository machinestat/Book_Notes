---
title: "JSON Data"
output: pdf_document
---

## Introduction

JavaScript Object Notation(JSON)
* Standard for "serializing" data objects, usually in files
* Human-readable,useful for data interchange
* Also useful for representing & sorting semistructured data
* No longer tiedto JavaScript
* Parsers fro many languages

Basic contructs(recursive)
* Base values: number, string, boolean,...
* Object{}:sets of label-value pairs, "label" is also called property
* Arrays[]: lists of values

Syntactically valid JSON

 Adheres to basic structual requirements + confirms to specified schema
 * Sets of label-value pairs
 * Arrays of values
 * Base values from predefined types

```
{ "type":"object",
  "properties": {
     "Books": {
        "type":"array",
        "items": {
           "type":"object",
           "properties": {
              "ISBN": { "type":"string", "pattern":"ISBN*" },
              "Price": { "type":"integer",
                         "minimum":0, "maximum":200 },
              "Edition": { "type":"integer", "optional": true },
              "Remark": { "type":"string", "optional": true },
              "Title": { "type":"string" },
              "Authors": { 
                 "type":"array",
                 "minItems":1,
                 "maxItems":10,
                 "items": {
                    "type":"object",
                    "properties": {
                       "First_Name": { "type":"string" },
                       "Last_Name": { "type":"string" }}}}}}},
     "Magazines": {
        "type":"array",
        "items": {
           "type":"object",
           "properties": {
              "Title": { "type":"string" },
              "Month": { "type":"string",
                         "enum":["January","February"] },
              "Year": { "type":"integer" }}}}
}}


```