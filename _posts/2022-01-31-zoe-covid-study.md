---
layout: post
date:   2022-01-31
title:  "ZOE Covid Study - the public data files"
---

* TOC
{:toc}

## 1. Disclaimer

This is not an endorsement of ZOE estimates, or their public communications.

ZOE methods are not fully specified.  I notice various errors in ZOE communications, but I cannot find all the errors.  I have not found much comment from independent experts. 

I am not an expert.

## 2. ZOE data is published on Google Cloud Storage

[ZOE][COVID-symptom-study] collect Covid test results and symptoms using a survey app.  They estimate Covid cases and publish them on a public web page.  More information is shown on a page "for app users only", which helps motivate people to take part.

[COVID-symptom-study]: https://en.wikipedia.org/wiki/COVID_Symptom_Study

The "for app users only" graphs are also published as `covid-public-data` on Google Cloud Storage, along with other data files.  For example, the report with today's graphs can be downloaded from this URL:

<https://storage.googleapis.com/covid-public-data/report/covid_symptom_study_report_20220131.pdf>

<figure style="border: solid"><img src="/assets/for-post/2022-01-31-zoe-covid-study/covid_symptom_study_report.png" alt="We estimate there have been 187669 daily new cases of symptomatic COVID in the UK on average over the two weeks up to 29 January 2022. This is based on the number of newly symptomatic app users per day, and the proportion of these who give positive swab tests."></figure>

There is an [online file browser][GS-browser], but it is slow.  If you try to download multiple files at once, it says you need to use `gsutil cp`.  See [official instructions to install gsutil][gsutil-install]. Alternatively, some Linux users may like to install gsutil [using Snap][google-cloud-sdk-snap].

I have also put a [few related scripts][my-scripts] up on GitHub.

[GS-browser]: https://console.cloud.google.com/storage/browser/covid-public-data;tab=objects?prefix=&forceOnObjectsSortingFiltering=false
[gsutil-install]: https://cloud.google.com/storage/docs/gsutil_install
[google-cloud-sdk-snap]: https://snapcraft.io/google-cloud-sdk
[my-scripts]: https://github.com/sourcejedi/nova-covid

## 3. Main data files

New data files are added each day.  You can download a different day by changing the date in the URL (your web browser address bar).  Note some older versions use different formats and different definitions.  Here are links to the most recent versions, as of today:

### 3.1 [covid_symptom_study_report_20220131.pdf][covid_symptom_study_report_20220131]

[covid_symptom_study_report_20220131]: https://storage.googleapis.com/covid-public-data/report/covid_symptom_study_report_20220131.pdf

"Daily COVID Infections Report", published 2022-01-31. "Analysis by ZOE and King's College London". The report includes:

* An explicit note that ZOE use a 14 day average for their case estimates.
* UK incidence estimates \["daily new cases of symptomatic COVID"\], graphed over time:
  * Incidence overall
  * Incidence within people "double vaccinated" (2 doses or more)
  * Incidence rates by UK nation
  * Incidence rates by English region
* Incidence of respiratory symptoms: COVID vs non-COVID
* Changelog

...and more. Please remember the disclaimer above. I am not attempting to list what is "wrong" here. E.g. known weirdnesses, unspecified methods, or limitations which might not have been stated *by anyone*.

### 3.2 [incidence_20220129.csv][incidence_20220129]

[incidence_20220129]: https://storage.googleapis.com/covid-public-data/csv/incidence_20220129.csv

Incidence time series, estimated using data from test specimens up to 2022-01-29. Each estimate is an average, for the 14-day period ending in the specified date.  I interpret the remaining columns as:

* Lower and upper "confidence intervals". These match current ZOE graphs, except for the "by vaccination status" graph. See  [ZOE confidence intervals][ZOE-CI].
* Unweighted totals: 
  * "Newly sick". This is a very broad range of symptoms (pre-test data). "Newly sick" users are invited to take PCR tests if they live in England. This number is the total over the 2 week period. To obtain the daily average, divide by 14.
  * The number of "active" reporting users. The definition of "active" might be more generous than you expect. This is used as a denominator for the "newly sick".
  * Total tests, and positive tests. These only include people who were "newly sick".
* Regional population. Used to convert estimates of case rates into estimates of absolute case numbers.

[ZOE-CI]: /2022/02/27/zoe-covid-confidence-intervals.html

### 3.3 [prevalence_history_20220131.csv][prevalence_history_20220131]

[prevalence_history_20220131]: https://storage.googleapis.com/covid-public-data/csv/RevisedStats/prevalence_history_20220131.csv

Prevalence time series \["active cases"\] estimated on 2022-01-31.

In a [paper from 2020][ZOE-method-prevalence], ZOE derived this prevalence from the 14-day incidence estimates. This calculation uses a curve of recovery probability, estimated from the whole population.

The dates were shifted by one day today, as per the Changelog (see above). So be careful if you compare today's file to previous ones.

[ZOE-method-prevalence]: /2022/02/02/zoe-covid-study-part-2-methods.html

## 4. All available files

For convenience, here is a full [file list][gsutil-ls]. Obtained using `gsutil ls -r -l gs://covid-public-data`.

[gsutil-ls]: /assets/for-post/2022-01-31-zoe-covid-study/gsutil-ls-recursive.txt
