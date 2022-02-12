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

  > The main adjustments we’ve made to our calculations are:
  >  * Changing the definition of ‘newly sick’ to include more people in our estimate calculations
  >  * Inclusion of Lateral Flow Test results
  >  * Adjustment by both age and vaccination status

  ZOE later showed weekly graphs of incidence by age group.  I assume the graph shows the same age groups used for the adjustment: 0-18, 18-35, 35-55, 55-75, 75-120.[sic]

  Data files starting `incidence_20210717.csv` include columns showing *unweighted* totals for testing, "newly sick", and "active users".  (Previously this was only available for the most recent day, at [latest/incidence%20table.csv](https://covid-assets.joinzoe.com/latest/incidence%20table.csv)).

* 2021-05-12: v3: <https://covid.joinzoe.com/post/covid-estimates-revised-after-change-to-methodology>

  Users' reports are now stratified by their vaccination status.  Vaccination was high among app users, which was biasing the estimates down.

* 2021-02-23: v2: <https://covid.joinzoe.com/post/covid-rates-calculation-changed>

  ZOE start excluding likely vaccine "after-effects", if they happen in the three days after vaccination.
  
  "You might notice the % positive tests are higher in the new reports - lateral flow test results are not included in this estimate anymore (or the incidence calc) due to different sensitivity.  They are still included in lots of research and analysis we do, please still log them!" - [@marksgraham_](https://twitter.com/marksgraham_/status/1364261105657257989)
  
  If you compare reports before and after, there might also be a small change to the % newly unwell data, even before any vaccination.

## 3. Original "ZOE" paper

[Detecting COVID-19 infection hotspots in England using large-scale self-reported data from a mobile application: a prospective, observational study](https://www.thelancet.com/journals/lanpub/article/PIIS2468-2667(20)30269-3/fulltext).

ZOE Covid Study has a complex calculation for local areas, to detect "hotspots". The paper explains local areas in England are interpolated, from (symptomatic) incidence estimates of the 7 NHS regions.

The incidence for the 7 NHS regions in England is "released daily". So, these were the same estimates shown in the "daily new cases" section on the ZOE website.  The method was:

1. <b>Users of ZOE's app "are asked to record each day whether they feel physically normal"</b>. If not, they are asked "to log any symptoms and keep a record of any COVID-19 tests and their results".
2. The exact questions used are shown in the appendix. They identify 19 different symptoms. There was also a free text entry field.
3. "Users who logged themselves as healthy at least once in a 9-day period and then reported" ... "any of the symptoms
asked about in the app" were termed "newly sick".
4. ZOE calculate "the proportion of users who report as newly sick". The [denominator](https://en.wikipedia.org/wiki/Denominator) is not spelled out. I think the correct denominator is the total users who "logged themselves as healthy at least once in the 9-day period".
5. Based on "incidence table.csv", this proportion appeared to be termed "avg. % of newly-sick/day", suggesting they use an average over several days. See point 7. The denominator appeared to be termed "active users".
6. Newly sick users "were sent invitations to book a [PCR] test through the DHSC national testing programme". This allowed ZOE users in England (only) to access PCR tests for symptoms that would not otherwise qualify. "They were then asked to record the result of the test in the app".
7. "We took <b>14-day averages</b> ... to calculate the percentage of positive tests among newly sick users". Tests are assigned to the date the swab was taken. <b>Note these test-based figures were released "with a 4-day reporting lag"</b>, to make sure enough positive and negative results were available from the swabs.
8. <b>To estimate incidence rates, the % newly sick (from step 4) and the % positive tests (from step 7) are "combined" by multiplying them together</b>.
9. <b>In this version, cases were not stratified or re-weighted e.g. by age or household income</b>.
10. 95% confidence intervals were calculated based on the test data. The more positive tests there were, the narrower the confidence intervals would be. 

I was able to reproduce the same incidence estimate from the "newly sick" and testing data in "incidence table.csv".

The UK prevalence published on the ZOE website and in "prevalence_history_*.csv", was derived from the 14-day incidence estimates, and a curve of recovery probability estimated from the whole population.

## 4. 2020-11-04 change to symptom questions, including runny nose and sore throat

"Several direct symptom questions were added to the app" on 2020-11-04, according to a [paper](https://www.thelancet.com/journals/lanchi/article/PIIS2352-4642(21)00198-X/fulltext) published 2021-08-03.

According to the ZOE blog 2021-03-18, any of [20 symptoms](https://web.archive.org/web/20210319152354/https://covid.joinzoe.com/post/the-20-symptoms-of-covid-19-to-watch-out-for) were sufficient for ZOE to offer you a PCR test (in England).  These include runny nose and sore throat, which are among the most common early symptoms.  These symptoms were not included in the original ZOE paper (below).

The [code](https://github.com/zoe/covid-tracker-react-native/commit/39ebcd5a3beea837ca75522fffdd490db049325e#diff-41c1aa97ff22cecb0746ef2c08888371a941110072c69925850807217b017550R53)
for the new symptom assessment was finalized on 2020-11-03.  It prompted for an additional 13 symptoms.

The current list of symptom prompts can be seen by using the app.
Or you can get the idea from the [latest version of the code](https://github.com/zoe/covid-tracker-react-native/blob/master/src/core/assessment/dto/AssessmentInfosRequest.ts).

