---
layout: post
date:   2022-02-02
title:  "ZOE Covid Study - part 2 - the method"
---

[ZOE][ZOE] release daily estimates of incidence, or "new cases of symptomatic COVID", for the 7 NHS regions of England.  Here is a reference of their method, with citations.

This is presented in reverse chronological order. Sorry. It seemed to make sense at the time.

See also [ZOE Covid Study - the public data files](/2022/01/31/zoe-covid-study.html).

[ZOE]: https://en.wikipedia.org/wiki/COVID_Symptom_Study

* TOC
{:toc}

## 1. Disclaimer

This is not an endorsement of ZOE estimates, or their public communications.

ZOE methods are not fully specified.  I notice various errors in ZOE communications, but I cannot find all the errors.  I have not found much comment from independent experts. 

I am not an expert.


## 2. ZOE method changes

If you look at ZOE estimates by publish date, you will see 4 discontinuities. These correspond to method changes. Here is a list, including a link to the announcement of each change. I refer to the different methods as "v1" to "v5".

<!-- Note: dropped down to heading level 4 here. Heading level 3 looks bigger than I want, in my blog theme. -->

#### 2021-10-07: v5: ["Future-proofing our COVID estimates"][v5]

[v5]: https://covid.joinzoe.com/post/future-proofing-our-covid-estimates

Note: the [daily report](/2022/01/31/zoe-covid-study.html#3-main-data-files) had already stopped showing incidence rates separately for people with 0 or 1 dose of vaccine. Separate incidence is still shown for 2+ doses.

Starting in this version, England incidence is now equal to the sum of each NHS region. This means England incidence is now stratified by region. (By the same test, UK incidence appears to have always been stratified by nation).

#### 2021-07-21: v4: ["COVID estimates updated as more people are being vaccinated"][v4]

[v4]: https://covid.joinzoe.com/post/covid-estimates-updated-vaccine

> The main adjustments we’ve made to our calculations are:
>  * Changing the definition of ‘newly sick’ to include more people in our estimate calculations
>  * Inclusion of Lateral Flow Test results
>  * Adjustment by both age and vaccination status

On the 30th, the daily report showed incidence rates among people with 0, 1, and 2+ vaccine doses.  Also, ZOE later showed graphs of incidence rate by age group: 0-17, 18-34, 35-54, 55-74, 75+.  I assume the graph shows the same age groups used for the adjustment.

Data files starting "incidence_20210717.csv" include columns showing *unweighted* totals for testing, "newly sick", and "active users".  (Previously this was only available for the most recent day, at [latest/incidence table.csv](https://covid-assets.joinzoe.com/latest/incidence%20table.csv)).

#### 2021-05-12: v3: ["COVID estimates revised after change to methodology"][v3]

[v3]: https://covid.joinzoe.com/post/covid-estimates-revised-after-change-to-methodology

Users' reports are now stratified by their vaccination status (0 versus 1+ doses).  Vaccination was high among app users, which was biasing the estimates down.

#### 2021-02-23: v2: ["How we calculate COVID-19 incidence has changed and rates have now reduced"][v2]

[v2]: https://covid.joinzoe.com/post/covid-rates-calculation-changed

ZOE start excluding likely vaccine "after-effects", if they happen in the three days after vaccination.
  
"You might notice the % positive tests are higher in the new reports - lateral flow test results are not included in this estimate anymore (or the incidence calc) due to different sensitivity.  They are still included in lots of research and analysis we do, please still log them!" - [Mark Graham](https://twitter.com/marksgraham_/status/1364261105657257989)
  
If you compare reports before and after, there might also be a small change to the % newly unwell data, even before any vaccination.

#### v1: See paper below


## 3. Original "ZOE" paper

[Detecting COVID-19 infection hotspots in England using large-scale self-reported data from a mobile application: a prospective, observational study][ZOE-paper-2020-12-03].

ZOE Covid Study has a complex calculation for local areas, to detect "hotspots". The paper explains how local areas in England are interpolated, from (symptomatic) incidence estimates of the 7 NHS regions.

The incidence for the 7 NHS regions in England is "released daily". Therefore these were the same estimates shown on the ZOE website, under "daily new cases".  The method to calculate these was:

1. <b>Users of ZOE's app "are asked to record each day whether they feel physically normal"</b>. If not, they are asked "to log any symptoms and keep a record of any COVID-19 tests and their results". The exact questions are shown in the appendix. They identify 19 different symptoms. There was also a free text entry field.
2. "Users who logged themselves as healthy at least once in a 9-day period and then reported" ... "any of the symptoms
asked about in the app" were termed "newly sick".
3. <b>ZOE calculate "the proportion of users who report as newly sick".</b> The [denominator](https://en.wikipedia.org/wiki/Denominator) is not spelled out. I think the correct denominator is the total users who "logged themselves as healthy at least once in the 9-day period".
4. Based on "incidence table.csv", this proportion appeared to be termed "avg. % of newly-sick/day", suggesting they use an average over several days. See point 6. The denominator appeared to be termed "active users".
5. <b>Newly sick users "were sent invitations to book a [PCR] test through the DHSC national testing programme"</b>. This allowed ZOE users in England (only) to access PCR tests for symptoms that would not otherwise qualify. "They were then asked to record the result of the test in the app".
6. "We took <b>14-day averages</b>" "to calculate the percentage of positive tests among newly sick users". Tests are assigned to the date the swab was taken. <b>Note these test-based figures were released "with a 4-day reporting lag"</b>, to make sure enough positive and negative results were available from the swabs.
7. <b>To estimate incidence rates, the % newly sick (from step 4) and the % positive tests (from step 6) are "combined", by multiplying them together</b>.
8. <b>In this version, incidence was not stratified or re-weighted e.g. by age or household income</b>.
9. 95% confidence intervals were calculated based on the test data. The more positive tests there were, the narrower the confidence intervals would be.

I was able to reproduce the same incidence estimate from the "newly sick" and testing data in "incidence table.csv".

In this version, England is just treated as one big region.  This means the incidence for England is *not* the sum of the incidence for each region.

UK prevalence estimates were published on the ZOE website and in "prevalence_history_*.csv", derived from the 14-day incidence estimates, and a curve of recovery probability estimated from the whole population ("recovery model").

Please note that since this incidence ("I<sub>S</sub>") is not re-weighted, the prevalence derived from it ("P<sub>H</sub>") is not re-weighted either.<!--FIXME Insert link to followup blog post-->  Do not confuse this with the "symptom-based" prevalence ("P<sub>A</sub>"), which the paper explains is re-weighted.

Briefly, the real point of the paper is to define P<sub>H</sub> for smaller areas, by apportioning it according to P<sub>A</sub>.  The "H" subscript stands for "hybrid".  However, when you are looking at the level of NHS regions, please remember that particular P<sub>H</sub> is no more of a hybrid than I<sub>S</sub>.

[ZOE-paper-2020-12-03]: https://www.thelancet.com/journals/lanpub/article/PIIS2468-2667(20)30269-3/fulltext


## 4. 2020-11-04 change to symptom questions, including runny nose and sore throat

"Several direct symptom questions were added to the app" on 2020-11-04, according to a [paper](https://www.thelancet.com/journals/lanchi/article/PIIS2352-4642(21)00198-X/fulltext) published 2021-08-03.

According to the ZOE blog 2021-03-18, any of [20 symptoms](https://web.archive.org/web/20210319152354/https://covid.joinzoe.com/post/the-20-symptoms-of-covid-19-to-watch-out-for) were sufficient for ZOE to offer you a PCR test (in England).  These include runny nose and sore throat, which are among the most common early symptoms.  These symptoms were not included in the original ZOE paper (below).

The [code](https://github.com/zoe/covid-tracker-react-native/commit/39ebcd5a3beea837ca75522fffdd490db049325e#diff-41c1aa97ff22cecb0746ef2c08888371a941110072c69925850807217b017550R53)
for the new symptom assessment was finalized on 2020-11-03.  It prompted for an additional 13 symptoms.

The current list of symptom prompts can be seen by using the app.
Or you can get the idea from the [latest version of the code](https://github.com/zoe/covid-tracker-react-native/blob/master/src/core/assessment/dto/AssessmentInfosRequest.ts).


## 5. Earlier changes

These are probably not interesting.  I just had to dig them up to double-check.

#### 2020-07-08: ["Data update: New COVID prevalence figures for the UK"](https://covid.joinzoe.com/post/data-update-prevalence-covid)

ZOE produced a model of recovery from COVID, truncated at 30 days. This is now used to convert incidence to prevalence.  See paper above.  This provides the "swab test based prevalence".  Previous ZOE prevalence estimates were not based on ZOE incidence.

#### 2020-07-02: ["New daily COVID-19 cases in the UK have stopped falling this week"](https://covid.joinzoe.com/post/covid-incidence-stable)

"Results from these antibody tests provide information about past infections, so removing reported antibody tests from the analysis gives a more accurate reflection of the number of new cases in the population."

"This means that last week's incidence and this week's incidence are not directly comparable. However, COVID Symptom Study app users can view incidence trends directly through the app as we have corrected all of the incidence trend charts for the entire timeline in these plots for this comparison."

Note, at this time the website was not updated every day.  Weekly blogs, including comparisons against the previous week, began July 11.  The report available to app users was updated daily.

#### 2020-05-22: ["9,900 new COVID cases across England daily"](https://covid.joinzoe.com/post/covid-cases-england)

First estimate of incidence. "Calculated using swab testing and app symptom data collected over the last two weeks".
