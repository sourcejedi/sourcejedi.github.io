---
layout: post
date:   2022-08-24
title:  "ZOE Covid estimates and the 3 day bug"
---

Here is a story about the [ZOE Health Study](ZOE-health-study), told through graphs.

[ZOE-health-study]: https://en.wikipedia.org/wiki/Zoe_Health_Study

* TOC
{:toc}

### 1. "Daily percentage of contributors who report new symptoms, with or without a positive COVID test result."

There is a big wiggle in early August.

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/newly_symptomatic_contributors.png" alt="">

### 2. Zooming in on the wiggle.

I grabbed the daily data from the link in the [app source code](https://github.com/zoe/covid-tracker-react-native/blob/2.7.1-ota-34/src/core/content/ContentService.ts#L124).

The wiggle really stands out.  On August 5, 6 and 7, the value drops to just over 0.5%.  Either side of the drop, the value is over 1.5%.

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/newly_sick_table.png" alt="">

### 3. The drop was caused by a bug in the app.

On August 5, 6 and 7, there were 5 app reviews from people saying they couldn't log on the app.  Specifically, that they couldn't log themselves as "unwell".

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/app_review.png" alt="Google Play Apps [Android]. August 5, 2022.
Worse since intro of 'usual self'. This app worked really effectively during the height of the first wave of the pandemic, and I used it daily. Now I hardly use it at all as it crashes all the time and it's really frustrating. If you try to add anything to say you are feeling different from your usual self, you get a 'sorry, nope' message and it refuses to log. So you are either going to get false data as people will just say they are fine as that is what will log, or no data at all. Please fix!">

### 4. The ZOE "daily new cases" number is a 14 day average.

This is the number shown on the [ZOE website](https://health-study.joinzoe.com/data):

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/cases_screenshot.png" alt="Total number of new daily cases across the UK: 108,841">

It is described inside the ZOE app, in today's [COVID Infection Report](https://storage.googleapis.com/covid-public-data/report/zoe_health_study_report_20220824.pdf):

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/cases_definition.png" alt="Daily new cases of symptomatic COVID.
We estimate there have been 108,841 daily new cases of symptomatic COVID in the UK
on average over the two weeks up to 22 August 2022. This is based on the number of
newly symptomatic app users per day, and the proportion of these who give positive
swab tests." title=""> 

### 5. The effect of 3 low days on a 14-day average.

For simplicity, imagine everything is equal. Imagine the testing data is flat.

When 3 very low days enter a 14-day average, the average will dip.  When 3 low days leave the average, the average will jump back.

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/14_day_average.png" alt="">

### 6. The effect on the daily change in the 14-day average.

The bug caused ZOE "daily new cases" to rise over the previous three days.  It made some people worry that it was the start of a new wave.

Today, "daily new cases" dropped below the low point from four days ago.

<img src="/assets/for-post/2022-08-24-zoe-covid-3-day-bug/daily_change.png" alt="">

### 7. An alternative "early warning system".

Previous "Omicron" variants increased this weekly growth rate by 60 percentage points.

Experts noticed significant growth advantages in these variants *before* they caused large waves of infections.

I made a twitter list of [experts you might like to follow](https://twitter.com/i/lists/1521570760950702081).  I chose these experts for a high signal-to-noise ratio, about variants specifically.

Other changes can cause waves, such as seasonality and waning immunity.  However, I think these will change more gradually.  They will not cause a spike that appears to come out of the blue, like the original Omicron variant did.


---

The scripts and spreadsheets used to produce these graphs are [available on GitHub](https://github.com/sourcejedi/nova-covid).
