---
layout: post
date:   2022-02-02
title:  "ZOE Covid Study - part 2 - the method"
---

Here is a quick dump on [ZOE][ZOE]'s methods. See also [my reference of ZOE public data files](/2022/01/31/zoe-covid-study.html).

[ZOE]: https://en.wikipedia.org/wiki/COVID_Symptom_Study

* TOC
{:toc}

## 1. Disclaimer

This is not an endorsement of ZOE estimates, or their public communications.

ZOE methods are not fully specified.  I notice various errors in ZOE communications, but I cannot find all the errors.  I have not found much comment from independent experts. 

I am not an expert.

## 2. ZOE method changes

ZOE estimates by publish date have 4 discontinuities, where ZOE announced a method change.  I refer to these different methods as "v1", "v2" etc.

* 2021-10-07: v5: <https://covid.joinzoe.com/post/future-proofing-our-covid-estimates>
* 2021-07-21: v4: <https://covid.joinzoe.com/post/covid-estimates-updated-vaccine>

  Regarding "adjustments based on age group", ZOE later showed weekly graphs of incidence by age group.  I assume the graph shows the same age groups used for the adjustment: 0-18, 18-35, 35-55, 55-75, 75-120.[sic]

  Data files starting `incidence_20210717.csv` include columns showing *unweighted* totals for testing, "newly sick", and "active users".  (Previously this was only available for the most recent day, at [latest/incidence%20table.csv](https://covid-assets.joinzoe.com/latest/incidence%20table.csv)).

* 2021-05-12: v3: <https://covid.joinzoe.com/post/covid-estimates-revised-after-change-to-methodology>

  Users' reports are now stratified by their vaccination status.  Vaccination was high among app users, which was biasing the estimates down.

* 2021-02-23: v2: <https://covid.joinzoe.com/post/covid-rates-calculation-changed>

  ZOE start excluding likely vaccine "after-effects", if they happen in the three days after vaccination.
  
  "You might notice the % positive tests are higher in the new reports - lateral flow test results are not included in this estimate anymore (or the incidence calc) due to different sensitivity.  They are still included in lots of research and analysis we do, please still log them!" - [@marksgraham_](https://twitter.com/marksgraham_/status/1364261105657257989)
  
  If you compare reports before and after, there might also be a small change to the % newly unwell data, even before any vaccination.

## 3. Original "ZOE" paper

[Detecting COVID-19 infection hotspots in England using large-scale self-reported data from a mobile application: a prospective, observational study](https://www.thelancet.com/journals/lanpub/article/PIIS2468-2667(20)30269-3/fulltext).

* 2020-11-17: Study pre-print on medrxiv.org
* 2020-12-03: Study published in the Lancet.

## 4. Change to symptom questions, including runny nose and sore throat

"Several direct symptom questions were added to the app" on 2020-11-04, according to a [paper](https://www.thelancet.com/journals/lanchi/article/PIIS2352-4642(21)00198-X/fulltext) published 2021-08-03.

According to the ZOE blog 2021-03-18, any of [20 symptoms](https://web.archive.org/web/20210319152354/https://covid.joinzoe.com/post/the-20-symptoms-of-covid-19-to-watch-out-for) were sufficient for ZOE to offer you a PCR test (in England).  These include runny nose and sore throat, which are among the most common early symptoms.  These symptoms were not included in the original ZOE paper (below).

The [code](https://github.com/zoe/covid-tracker-react-native/commit/39ebcd5a3beea837ca75522fffdd490db049325e#diff-41c1aa97ff22cecb0746ef2c08888371a941110072c69925850807217b017550R53)
for the new symptom assessment was finalized on 2020-11-03.  It prompted for 13 new symptoms.

The current list of symptom prompts can be seen by using the app.
Or you can get the idea from the [latest version of the code](https://github.com/zoe/covid-tracker-react-native/blob/master/src/core/assessment/dto/AssessmentInfosRequest.ts).

(Not sure if the code links are still correct. They don't work for me at the moment, because GitHub is down)
