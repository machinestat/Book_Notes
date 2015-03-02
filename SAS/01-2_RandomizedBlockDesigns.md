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
*Expected mean squares* are the expectations of mean squares, and they are the quantities that are estimated by mean squares in an analysis of variance. The expected mean squares can be used to motivate test statistics, to compute standard errors for means and comparisons of means, and to provide a way to estimate the variance components. The basic idea is to examine the expected mean square for a factor and see how it differs under null and alternative hypothesis. For example, the expected mean square for treatments, $E[MS(Trts)] = \sigma^{2} + r\o^{2}$, can be used to determine how to set up a test statistic for treatment differences. The null hypothesis is $H_{0}:\mu_{1}=\mu_{2}=\cdots=\mu_{t}$. The expression $\o^{2}$ in E[MS(Trts)] is

$\o^{2}=\left(t-1\right)^{-1}\sum_{i=1}^{t}\left(\mu_{i}-\bar{\mu_{.}}\right)^{2}$

where $\bar{\mu_{.}}$ is the mean of the $\mu_{i}$. Thus, $\o^{2}=0$ is equivalent to $\mu_{1}=\mu_{2}=\cdots=\mu_{t}$. So, if the null hypothesis is true, MS(Trts) simply estimes $\o^{2}$ simply estimates $\sigma^{2}$. On the other hand, if $\mu_{1}=\mu_{2}=\cdots=\mu_{t}$ is false, the E[MS(Trts)] estimates a quantity larger than $\sigma^{2}$. Now MS(Error) estimates $\sigma^{2}$ regardlessof whether $H_{0}$ is true or false. Therefore, MS(Trts) and MS(Error) tend to be approximate the same magnitude if $H_{0}$ is true, and MS(Trts) tends to be larger than MS(Error) if $\mu_{1}=\mu_{2}=\cdots=\mu_{t}$ is false. So a comparison of MS(Trts) with MS(Error) is an indicator of whether $\mu_{1}=\mu_{2}=\cdots=\mu_{t}$ is ture or false. In this way the expected mean squares show that a valid test statistic is the ratio $F = MS(Trt)/MS(Error)$

Expected mean squares also can be used to estimate variance components, variances of treatment means, and differences between treatment means. Equating the observed mean squares to the expected mean squares provides the following system of equations:

$MS(Blks)=\hat{\sigma}^{2}+t\hat{\sigma}_{b}^{2}$  
$MS(Error)=\hat{\sigma}^{2}$

The solution for the variance component is  
$\hat{\sigma}^{2} = MS(Error)$  
and  
$\hat{\sigma}^{2}_{b} = \frac{1}{t}\left[MS(Blks)-MS(Error)\right]$ 

These are called **analysis of variance** estimates of the variance components. Using these estimates of the variance components,it follows that estimatesof $\hat{Var}\left[\bar{Y}_{1.}\right]$ and $\hat{Var}\left[\bar{Y}_{1.}-\bar{Y}_{2.}\right]$ are

$\hat{Var}\left[\bar{Y}_{1.}\right]=\left(\hat{\sigma}^{2}+\hat{\sigma }_{b}^{2}\right)/r$=$\frac{1}{rt}MS\left(Blks\right)+\frac{t-1}{rt}MS\left(Error\right)$

and

$\hat{Var}\left[\bar{Y}_{1.}-\bar{Y}_{2.}\right]=\frac{2}{r}MS(Error)$

## 2.2.4 Example: A Randomized Complete Blocks Design
The data set is RCB designed experiment as follow:

```
Obs    ingot    metal    pres

  1      1        n      67.0
  2      1        i      71.9
  3      1        c      72.2
  4      2        n      67.5
  5      2        i      68.8
  6      2        c      66.4
  .      .        .         .
  .      .        .         .
  .      .        .         .
 19      7        n      75.6
 20      7        i      84.9
 21      7        c      69.0

```
Blocks are ingots of a composition materia, and treatments are metals. Pieces of material from the same ingot are bonded using one of the metals as a bonding agent.



