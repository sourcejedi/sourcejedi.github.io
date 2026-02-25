---
layout: post
title:  "ZOE Covid Study - estimates for local areas"
---

* TOC
{:toc}

## 1. Disclaimer ##

These are working notes / analysis.  I needed to get them out of my head, and make it specific enough that it could be wrong (falsifiable).

Some ZOE statements are wrong (e.g. below).  This is why you should seek analysis by independent experts.  I cannot find every wrong statement.  I am not an expert.


## 2. Context ##

### 2.1 UK incidence estimate ###

ZOE's primary estimate is symptomatic incidence ("new cases").  It is estimated using "the number of newly symptomatic app users per day, and the proportion of those who give positive swab tests".  It is then "extrapolated" to the UK population, the population of 7 (ish) NHS regions in England, and each of the other 3 UK nations.

The method was [adjusted several times](/2022/02/02/zoe-covid-study-part-2-methods.html) in 2021.


### 2.2 UK prevalence estimate ###

ZOE also convert each incidence to prevalence ("active cases"), by using a model of the time it takes to recover.  It is possible to [reverse-engineer the recovery model](https://github.com/sourcejedi/nova-covid/tree/main/prevalence_from_incidence).

Caveat: ZOE's scientific paper claims to use a different recovery model.  As far as I can tell, it did use the same model. The paper appears to be  [mathematically inconsistent](https://sourcejedi.github.io/2022/06/01/zoe-covid-pubpeer.html).

Either way, the same recovery model works for all currently available ZOE prevalences.  This shows the recovery model has not changed since 2020.

In a later paper, ZOE showed changes in illness duration associated with viral variants, and with immunity (specifically vaccination).  They have not mentioned reviewing the effect on prevalence estimates.


### 2.3 Local prevalence estimates ###

ZOE also publish estimates by local authority areas.  The methods above do not work for these smaller areas, because there are not enough tests.

A second estimate of prevalence "P_A" is calculated from symptom assessments.  The symptom model was trained using COVID tests.  However, these are not the estimates (currently) shown on the ZOE website and mobile app.

The official local estimate is a hybrid, "P_H".  For each large UK region, it takes the published prevalence and divides it between the small areas, so that each local estimate is proportional to "P_A".

This was explained in the [2020 "hotspots" paper](/2022/02/02/zoe-covid-study-part-2-methods.html#3-original-zoe-paper).


## 3. Local prevalence estimates are smoothed using an 8 day average ##

Local estimates are published at [covid-public-data](https://sourcejedi.github.io/2022/01/31/zoe-covid-study.html), e.g. `/csv/utla_prevalence_map_20221030.csv`.  The official estimates are shown by UTLA (Upper Tier Local Authority), as described in the "hotspots" paper.  However, UTLA estimates are currently calculated by adding up distinct estimates for each LAD (Local Authority District).

Both the `respondent` and `active_cases` columns are 8-day rolling averages.  The unsmoothed values for each LAD are published as `respondent_count` and `corrected_covid_positive` in `csv/corrected_prevalence_region_trend_20221030.csv`.

TODO: differs from blog, and the other references that disagree with that...

TODO: upload and link prevalence_digest
