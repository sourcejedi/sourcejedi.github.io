---
layout: post
date:   2022-02-02
title:  "ZOE Covid Study - part 2 - the method"
---

[ZOE][ZOE] release daily estimates of incidence, or "new cases of symptomatic COVID", for the 7 NHS regions of England. Here is an introduction to their method, complete with citations.

This is presented in reverse chronological order. Sorry. It seemed to make sense at the time.

See also [ZOE Covid Study - the public data files][covid-public-data].

[ZOE]: https://en.wikipedia.org/wiki/COVID_Symptom_Study
[covid-public-data]: /2022/01/31/zoe-covid-study.html

* TOC
{:toc}

## 1. Disclaimer

This is not an endorsement of ZOE estimates, or their public communications.

ZOE methods are not fully specified. I notice various errors in ZOE communications, but I cannot find all the errors. I have not found much comment from independent experts. 

I am not an expert.


## 2. ZOE method changes

If you look at ZOE estimates by publish date, you will see 4 discontinuities. These correspond to method changes. Here is a list, including a link to the announcement of each change. I refer to the different methods as "v1" to "v5".

<!-- Note: dropped down to heading level 4 here. Heading level 3 looked bigger than I wanted, in my blog theme. -->

#### 2021-10-07: v5: ["Future-proofing our COVID estimates"][v5]

[v5]: https://covid.joinzoe.com/post/future-proofing-our-covid-estimates

> The ZOE COVID Study has been collecting key information on COVID-19 vaccines and infections since the start of the UK’s vaccination programme. Thanks to this data, ZOE and King's College London (KCL) have been able to assess the relative risk reduction from vaccines [...] and track changes over time in the real world, a.k.a vaccine effectiveness. The relative risk reduction measured in the study can be used to predict an incidence rate in unvaccinated and partially vaccinated users from the incidence in the fully vaccinated group.

Method v4 was already adjusted by vaccination status. In method v5, a different adjustment is used. Neither adjustment was specified. This leaves us with several important questions.

The new estimate appears smoother over time. This is consistent with the narrower confidence interval shown. ZOE emphasized this comparison, so I assume good faith. If you look at other graphs to compare the intervals, you will need more caution. See [ZOE confidence intervals](/2022/02/27/zoe-covid-confidence-intervals.html).

ZOE say the new method "effectively applies a weighted average to a cohort". They also describe it as applying "a new weighting function".

The main rationale is that "among some of our age cohorts, unvaccinated contributors have all but vanished". To narrow the confidence interval, the new estimate of relative risk reduction must be using larger sample sizes.

Q1: I see two possibilities to increase sample sizes. One is to average over a longer time period, where there will be more infections. The other is to change the age groups used in this calculation. Reducing the number of age groups would increase the sample size.

Q1.1: ZOE claim "even if we lost all unvaccinated users from our study", the method can still "calculate the relative risk in the unvaccinated" and estimate overall incidence. I do not know how this fits when the same announcement shows vaccine effectiveness can wane over time (or because of new variants, as mentioned in the ZOE video about waning).

Q1.2: Similarly, how does it respond when the Omicron variant sweeps through, quickly lowering vaccine effectiveness? Does it respond slowly, causing an overestimation of both VE and cases in the unvaccinated? Sadly, the implication here has not been commented on by ZOE, or other experts. Contrawise, some commentators suggest ZOE estimates [understate][ZOE-omicron-understate] the Omicron wave.

Q2: Considering the timing, and previous ZOE commentary on waning and boosters, one might hope the "future proof" method also supported third doses. However ZOE were not clear on this. They have not mentioned any results for a third dose. An alternative might be to hope that adjusting for age would effectively adjust for the takeup of this booster dose.

The [daily report][daily-report] had already stopped showing incidence rates separately for people with 0 or 1 dose of vaccine. Separate incidence is still shown for 2+ doses.

ZOE periodically invite questions. I submitted a [few short questions][v5-email] on 2022-03-17, but I have not seen any answers or response.

[ZOE-waning]: https://covid.joinzoe.com/post/covid-vaccine-protection-fading

[ZOE-waning-video]: https://covid.joinzoe.com/post/are-covid-vaccines-working-boosters-webinar

[ZOE-omicron-understate]: https://twitter.com/PaulMainwood/status/1494015094182842376

[daily-report]: /2022/01/31/zoe-covid-study.html#3-main-data-files

[v5-email]: /assets/for-post/2022-02-02-zoe-covid-study-part-2-methods/2022-03-17 How does the covid estimate (incidence) work.pdf


#### 2021-07-21: v4: ["COVID estimates updated as more people are being vaccinated"][v4]

[v4]: https://covid.joinzoe.com/post/covid-estimates-updated-vaccine

> The main adjustments we’ve made to our calculations are:
>  * Changing the definition of ‘newly sick’ to include more people in our estimate calculations
>  * Inclusion of Lateral Flow Test results
>  * Adjustment by both age and vaccination status

Method v3 simply re-weighted the vaccinated and unvaccinated cohorts, to match vaccination in the overall population.  My current guess is that v4 is similarly re-weighted by vaccination status and age group.

On the 30th, the daily report showed incidence rates among people with 0, 1, and 2+ vaccine doses.  Also, ZOE later showed [graphs of incidence rate by age group][incidence-age-groups]: 0-17, 18-34, 35-54, 55-74 and 75+.[[Note]][incidence-age-groups-fixed]  I assume the graph shows the same age groups used for the adjustment.

Another possible method can be seen in the ONS random survey.  ONS model incidence as a smooth function of age.  The [ONS weekly report][ONS-survey] includes smooth graphs of incidence by single year of age, animated over time.  However, ZOE have not showed any graph like this.

The data files "incidence_20210717.csv" and newer include columns showing *unweighted* totals for testing, "newly sick", and "active users".  (Previously this was only available for the most recent day, in [incidence&nbsp;table.csv](#31-incidence-tablecsv).

Starting in this version, England incidence is now equal to the sum of each NHS region. This implies the England incidence is now weighted by region. (By the same test, UK incidence appears to have always been weighted by nation).

[incidence-age-groups]: https://covid.joinzoe.com/post/covid-bounces-back-as-cases-start-to-rise
[incidence-age-groups-fixed]: https://twitter.com/sourcejedi/status/1491512209951895558

[ONS-survey]: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/conditionsanddiseases/bulletins/coronaviruscovid19infectionsurveypilot/28january2022


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

Incidence for the 7 NHS regions in England was "released daily". Therefore these were the same estimates shown on the ZOE website, under "daily new cases".  The incidence calculation is described in several pieces:

1. <b>Users of ZOE's app "are asked to record each day whether they feel physically normal"</b>. If not, they are asked "to log any symptoms and keep a record of any COVID-19 tests and their results". The exact questions are shown in the appendix. They identify 19 different symptoms. There was also a free text entry field.
2. "Users who logged themselves as healthy at least once in a 9-day period and then reported" ... "any of the symptoms
asked about in the app" were termed "newly sick".
3. <b>ZOE calculate "the proportion of users who report as newly sick".</b>
4. <b>Newly sick users "were sent invitations to book a [PCR] test through the DHSC national testing programme"</b>. This allowed ZOE users in England (only) to access PCR tests for symptoms that would not otherwise qualify. "They were then asked to record the result of the test in the app".
5. "We took <b>14-day averages</b>" "to calculate the percentage of positive tests among newly sick users". Tests are assigned to the date the swab was taken. Test-based estimates were released "with a 4-day reporting lag", to make sure enough positive and negative results were available from the swabs.
6. <b>To estimate incidence rates, the % newly sick (step 3) and the % positive tests (step 5) are "combined", by multiplying them together</b>. This step is in the supplementary appendix.
7. <b>In this version, incidence was not stratified or re-weighted e.g. by age or household income</b>.
8. 95% confidence intervals were calculated based on the test data. The more positive tests there were, the narrower the confidence intervals would be.

The paper itself does not spell out:

1. The [denominator](https://en.wikipedia.org/wiki/Denominator) for the proportion of newly sick users.
2. Whether the proportion of newly sick in step 6 has been averaged over the 14 days.

### 3.1 incidence table.csv

For method v1, I was able to match ZOE incidence calculations from "newly sick" and testing data in [incidence&nbsp;table.csv][incidence table.csv].  This file is separate from [covid-public-data][covid-public-data].  I have not seen anyone else mention it.

[incidence table.csv]: https://github.com/sourcejedi/nova-covid#download-sample

The column `#_total_tests` is a 14-day total - the numbers match other ZOE documents.  We can match the column `%_+ve_tests` using `+ve_tests ÷ total_tests`.

`avg._%_of_newly-sick/day` is provided to 2 decimal places.  If we accept this limited precision, we can match `est._daily_cases` by calculating `avg._%_of_newly-sick/day × (+ve_tests ÷ total_tests) × population`.

The values of `avg._%_of_newly-sick/day` appeared to match the graphs in the [daily report][daily-report]. In particular, the values for England matched the 14-day average on the "newly sick" graph. By comparing the report with the scientific paper above, it appears the denominator is the number of users who logged on a given day, who also logged at least once during the previous 9 days:

> Newly Sick Users by Day (% of Active Users)
>
> Active users are those who have been logging regularly in the past 10 days. Newly sick
> users are active users who haven't reported any symptoms for at least 9 days before
> reporting one of the following symptoms: [...]

Around Christmas day 2020, we can see the incidence estimate for England is smooth despite sharp changes in the un-averaged graph of newly sick users.  This proves the newly sick proportion used in step 6 is an average over the 14 days.

This helped clarify the scientific paper for me.  Some of the above could be imperfect approximations, and I have not checked as much as I could.

The daily report also had a graph "Positive Test Results by Day (% of Invited Test Takers)", and a 14-day average.  However this did not match `%_+ve_tests`.  I have no explanation how it could differ by so much.

My `est._daily_cases` calculation effectively "took 14-day averages" first, and then calculated proportions.  The paper did not spell out this order of operations, but I think it makes the most sense.

I am not sure how `#_active_users` is aggregated over the 14 days.  It seems an odd name to use for an average, and the values are always shown as whole numbers.  I sometimes thought of it as unique users over the 14 days instead.  That might be consistent with `#_total_tests`, which would need to be de-duplicated somehow.  However I don't know which option would work better.

In method v4 a `#_newly_sick` column was added; the values only make sense as 14-day totals.  The `#_newly_sick` column replaced the original `avg._%_of_newly-sick/day`.  I think ZOE are inviting us to calculate the proportion ourselves, i.e.  `newly_sick ÷ 14 ÷ active_users`.

The transparency provided by all of ZOE's data files would be enhanced, if ZOE could briefly document them or answer relevant questions or officially mention their existence.


### 3.2 Other remarks

In this initial method, England is just treated as one big region.  This means the incidence for England is *not* the sum of the incidence for each region.

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
