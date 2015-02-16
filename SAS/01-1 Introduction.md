---
title: "Introduction"
output: pdf_document
---

## **1.1 Type of Models That Produce Data**
Data sets presented here come from three types of sources: (1) designed experiments, (2) sample surveys, and (3) observational studies.

In designed experiments, some form of treatment is applied to experimental units and responses are observed. In sample surveys, data are collected according to a plan, called a survey design, but treatments are not applied to units. Instead, the units, typically people, already posses certain attributes such as age or occupation. It is often of interest to measure the effect of the attributes on, or their association with, other attributes. In observational studies, data are collected on units that are available, ratherthan on units chosen according to a plan.

## **1.2 Statistical Models**
Statistical models for data are mathematical descriptions of how the data conceivably can be produced. Models consist of at least two parts: (1) a formula relating the response to all explanatory variables (e.g., effects), and (2) a description of the probability distribution assumed to characterize random variation affecting the observed response.

Consider the experiment with five drugs (say, A, B, C, D, and E) applied to subjects to control blood pressure. Let $\mu_{A}$ denote the mean blood pressure for subjects treated with drug A, adn define $mu_{B}$, $mu_{C}$, $mu_{D}$ and $mu_{E}$ similarly for the other drugs. The simplest model to describe how observations from this experiment were produced for drug A is $Y_{A} = \mu_{A} + e$. That is, a blood pressure observation $(Y_{A})$ on a given subject treated with drug A is equal to the mean of drug A plus random variation resulting from whatever is particular to a given subject other than drug A. The random variation, denoted by the term $e$, is called the **error** term in _Y_. It follows that $e$ is a random variable with a mean of zero and a variance of $\sigma^{2}$. This is the simplest version of a **linear statistical model**.

The model $Y_{A} = \mu_{A} + e$ is called a **means model** because the only term on the right-hand side of the model other than random variation is a treatment mean. The mean can be modeled in various ways. The first approach leads to an effects model. Define the effect of drug A as $\alpha_{A}$ such that $\mu_{A} = \mu + \alpha_{A}$, where $\mu$ is defined as the intercept. This leads to the one-way **analysis variance** (ANOVA) model $Y_{A} = \mu + \alpha_{A} + e$, the simplest form of an effects model. Note that the effects model has more parameters (in this case, $\mu$ and the $\alpha_{i}$) than factor levels(in this case 5). Such models are said to be **over-parameterized** because there are more parameters to estimate than there are unique items of information. Such models reuire some constrint on the solution to estimate the parameters. Often, the constraint involves defining $\mu$ as the overall mean implying $\alpha_{A} = \mu_{A} - \mu$ and thus   

$$ \sum_{i = A}^{E} = 0$$

This is called a sum-to-zero constraint. 