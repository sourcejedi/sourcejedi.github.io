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

[ZOE][ZOE] collect Covid test data and symptoms using a survey app.  They estimate Covid cases and publish them on a public web page.  More information is shown on a page "for app users only", which helps motivate people to take part.

[ZOE]: https://en.wikipedia.org/wiki/COVID_Symptom_Study

The "app users only" graphs are also published as `covid-public-data` on Google Cloud Storage, along with several other data files.  For example, the report with today's graphs which can be downloaded from this URL:<br>
<https://storage.googleapis.com/covid-public-data/report/covid_symptom_study_report_20220131.pdf>

<figure style="border: solid"><img src="/assets/for-post/2022-01-31-zoe-covid-study/covid_symptom_study_report.png" alt="We estimate there have been 187669 daily new cases of symptomatic COVID in the UK on average over the two weeks up to 29 January 2022. This is based on the number of newly symptomatic app users per day, and the proportion of these who give positive swab tests."></figure>

The [GS browser][GS-browser] web app is slow.  Also, the browser does not support bulk downloads.  It recommends using the `gsutil cp` command.  There are [official instrucions to install gsutil][gsutil-install], but I [installed it on Linux using Snap][google-cloud-sdk-snap].

[GS-browser]: https://console.cloud.google.com/storage/browser/covid-public-data;tab=objects?prefix=&forceOnObjectsSortingFiltering=false
[gsutil-install]: https://cloud.google.com/storage/docs/gsutil_install
[google-cloud-sdk-snap]: https://snapcraft.io/google-cloud-sdk

## 3. Main data files

New data files are added each day.  To download a different day, change the date in the URL (your web browser address bar).  Note some older versions use different formats and different definitions.  As of today, the following were the most recent versions:

### 3.1 [covid_symptom_study_report_20220131.pdf][covid_symptom_study_report_20220131]

[covid_symptom_study_report_20220131]: https://storage.googleapis.com/covid-public-data/report/covid_symptom_study_report_20220131.pdf

_Daily COVID Infections Report_, published 2022-01-31. "Analysis by ZOE and King's College London".

* An explicit note, that ZOE still use a 14 day average for their case estimates.
* UK incidence [new cases] estimates, graphed over time:
  * Incidence total
  * Incidence within people "double vaccinated" (2 doses or more)
  * Incidence rates by UK nation
  * Incidence rates by English region
* Incidence of respiratory symptoms: COVID vs non-COVID.
* Changelog

...and more. Please note the disclaimer at the start of this blog post. I am not attempting to list what is "wrong" here e.g. known weirdnesses, unspecified methods, limitations which have not been stated *anywhere*.

### 3.2 [incidence_20220129.csv][incidence_20220129]

[incidence_20220129]: https://storage.googleapis.com/covid-public-data/csv/incidence_20220129.csv

Incidence time series, estimated using data from test specimens up to 2022-01-29. Each estimate is an average, for the 14-day period ending in the state date.  I interpret the remaining columns as:

* Lower and upper "confidence limits". These should be 95% confidence limits. They match ZOE graphs, except for the "by vaccination status" graph.
* Unweighted totals: 
 * "Newly sick". This is a very broad range of symptoms (pre-test data). "Newly sick" users are invited to take PCR tests in England.
 * The number of "active" reporting users. The definition of "active" appears surprising generous. This is used as the denominator for the "newly sick".
 * Total tests, and positive tests. These only include people who are "newly sick".
* Regional population. Used to convert estimates of case rates into estimates of absolute case numbers.

### 3.3 [prevalence_history_20220131.csv][prevalence_history_20220131]

[prevalence_history_20220131]: https://storage.googleapis.com/covid-public-data/csv/RevisedStats/prevalence_history_20220131.csv

Prevalence ["active cases"] time series. Estimated on 2022-01-31, using data from test specimens up to 2022-01-29.

Note, as per the Changelog (above), the dates were shifted by one day today. So take care if comparing today's file to previous ones.

Initially, this prevalence was derived from the 14-day incidence estimates, and a curve of recovery probability estimated from the whole population. It seems quite technical; I don't mind so much not knowing *exactly* how this method has changed, if at all.

## 4. All available files

For convenience, here is a full [file list][gsutil-ls]. Obtained using `gsutil ls -r -l gs://covid-public-data`.

[gsutil-ls]: /assets/for-post/2022-01-31-zoe-covid-study/gsutil-ls-recursive.txt
