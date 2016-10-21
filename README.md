# README
Randall  
October 21, 2016  

# Introduction

`ggSurvival` is an R package designed to work with 

# Quick Start

This section is for people with a introductory understanding of R who just want to make a pretty Kaplan-Meier now.

## Install ggSurvival



## Load packages


```r
library(ggSurvival)

library(ggplot2)
library(survival)
library(dplyr)
library(tidyr)
```

If any of the packages other than ggSurvival are not already installed you can install them from CRAN using  `install.packages()`, or if you are using RStudio Tools > Install Packages.

## Data Set

As an example, I will be using the `cancer` data set from the `survival` package. This dataset is the overall survival of 228 lung cancer patients. See `?cancer` for more details. 

Please do not take anything I do with this set to be suggestions for an appropriate analysis on these data. I am simply using this dataset as an example.


```
##   Instatution time status  sex
## 1           3  306      1 Male
## 2           3  455      1 Male
## 3           3 1010      0 Male
## 4           5  210      1 Male
## 5           1  883      1 Male
## 6          12 1022      0 Male
```

Note the change I made to `status`, this dataset codes event status as `1 = censored` and `2 = dead`, R's survival function assumes that `0 = censored` and `1 = event`, so in this case I can just subtract 1 to get the correct values. Be very careful, coding for events is not uniform and people will sometimes use `0 = death` and `1 = censored` which, without correction, will make your analysis meaningless.

Next up, we combine the `time` and `status` vectors into a R survival object.


```r
Data$Surv = Surv(Data$time,Data$status)
```

## Plotting

Now we are ready to generate the plot.


```r
ggPrettySurv(srv = Data$Surv,Main = "Look It's A Plot!")
```

![](README_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Or making a plot spit up by patient Gender:


```r
ggPrettySurv(srv = Data$Surv,Factor = Data$sex, Main = 'With More Colours!')
```

![](README_files/figure-html/unnamed-chunk-6-1.png)<!-- -->