---
title: "Randomized Block Designs"
output: pdf_document
---

## 2.1 Introduction
**Blocking** is a research technique that is used to diminish the effects of variation amongexperimental units. The units can be people, plants or any other objects that used in experimentation. **Blocks** are groups of units that are formed so that units within the blocks are as nearly homogeneous as possible. Then levels of the factor being investigated, called **treatments**, are **randomly assigned to units within the blocks**. An experiment conducted in this manner is called a **randomized blocks design**. Usually, the primary objectives are to estimate and compare treatment means. In most cases, the **treatment effects** are considered **fixed** because the treatments in the experiment are the only ones to which inference to be made. That is no conclusions will be drawn about treatments that were not employed in the experiment. Block effects are usually considered **random** because the blocks in the experiment constitute only a small subset of the larger set of blocks over which inferences about treatment means are to be made. The model for data from a randomized blocks design usually contains fixed effects for treatment contributions or factors and random effects for blocking factors contributions, making it a **mixed** model.

## 2.2 Mixed Model for a Randomized Complete Blocks Design

A randomized blocks design that has each treatment applied to an experimental unit in each block is called a **randomized complete blocks design** (RCBD). In the most common situation each treatment appears once in each block. Assume there $t$ treatments and $r$ blocks of $t$ experimental units and there will be one observation per experimental unit. Randomly assign each treatment to one experimental unit in each of the $r$ blocks, there are $tr$ experimental units altogether. Letting $Y_{ij}$ denote the response from the experimental unit that received treatment $i$ in block $j$, the equation for the model is  
$$ Y_{ij}=\mu +\tau_{i}+b_{j}+e_{ij}\cdots \cdots (2.1)$$              
where   
$i = 1, 2,...,t$  
$j = 1, 2,...,r$   
$\mu$ and $\tau$ are fixed parameters such that the mean for the $i^{th}$ treatment is $\mu_{i}=\mu+\tau_{i}$   
$b_{j}$ is the random effect associated with the $j^{th}$ block   
$e_{ij}$ is random error associated with the experimental unit in block $j$ that received treatment $i$.

Assumptions for random effects are as follows:

* Block effects are distributed **normally and independently** with mean 0 and variance $\sigma_{b}^{2}$; that is, $b_{j}(j = 1,2,\cdots, r)$ are distributed $iid$ $N$(0, $\sigma_{b}^{2}$).

* Errors $e_{ij}$ are distributed **normally and independently** with mean 0 and variance $\sigma^{2}$; that is, the $e_{ij}$ ($i = 1, 2, \cdots,t;j=1,2,\cdots,r$) are distributed $iid$ $N$(0, $\sigma^{2}$). The $e_{ij}$ are also distributed independently of the $b_{j}$.

## 2.2.1 Means and Variances from Randomized Blocks Design

The usual objectives of a randomized blocks design are estimate and compare treatment means using statistical inference. It follows from equation (2.1) that a a treatment mean, such as $\bar{Y_{1}}$, can be written as

$$\bar{Y_{1}} = \mu_{1} + \bar{b_{.}} + \bar{e_{1.}} \cdots \cdots (2.2)$$

Likewise, the difference between two means, such as $\bar{Y_{1}} - \bar{Y_{2}}$, can be written

$\bar{Y_{1}}-\bar{Y_{2}} = \mu_{1} - \mu{2} + \bar{e_{1.}}-\bar{e_{2.}} \cdots \cdots (2.2)$

From these expressions, the variances of $\bar{Y_{1.}}$ and $\bar{Y_{1.}} -\bar{Y_{2.}}$ are computed as

$Var\left [ \bar{Y_{1.}} \right ] = \left ( \sigma^{2}+\sigma^{2} \right )/r \cdots \cdots (2.4)$

$Var\left [ \bar{Y_{1.}} - \bar{Y_{2.}} \right ] = 2\sigma^{2}/r \cdots \cdots (2.5)$

Note that the difference between two means does _not_ involve $\sigma^{2}$ so they are estimated free of block variation.

## 2.2.2 The Traditional Method: Analysis of Variance
Analyss of variance (ANOVA) is a key component in analysis of data from a randomized block design. The table below is a standard ANOVA table for the RCBD.

ANOVA Table for Randomized Complete Blocks Design

|*Source of Variation*| *df*     | *MS*    |  *E[MS]*                    |
|---------------------|:--------:|---------|:---------------------------:|
|Blocks               |r - 1     |MS(Blks) | $\sigma^{2}+t\sigma^{2}_{b}$|
|Treatments           |t - 1     |MS(Trts) | $\sigma^{2}+r\o^{2}$        |
|Error	              |(r-1)(t-1)|MS(Error)| $\sigma^{2}$                |

## 2.2.3 Using Expeceted Mean Squares
*Expected mean squares* are the expectations of mean squares, and they are the quantities that are estimated by mean squares in an analysis of variance. The expected mean squares can be used to motivate test statistics, to compute standard errors for means and comparisons of means, and to provide a way to estimate the variance components. The basic idea is to examine the expected mean square for a factor and see how it differs under null and alternative hypothesis. For example, the expected mean square for treatments, $E[MS(Trts)] = \sigma^{2} + r\o^{2}$, can be used to determine how to set up a test statistic for treatment differences.
