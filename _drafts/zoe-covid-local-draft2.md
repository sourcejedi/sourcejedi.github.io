---
layout: post
title:  "ZOE Covid Study - estimates for local areas"
---

## 1. Two ZOE COVID estimates for local areas

ZOE publish multiple COVID estimates for local areas.  These include:

1. The *watch-list* in the [daily report][files-doc].  "UTLA \[Upper Tier Local Authority\] regions with the highest estimates of prevalence rates averaged over the past week".

   *Watch-list* estimates also match up with the [map on the website][zoe-data-page].
2. The *local trendline* in the ZOE app.  This is for your Local Authority District, or LAD, which can be smaller than a UTLA.  It is currently said to be [smoothed][zoe-blog-local-14d] using "a 14-day rolling average‍".

[files-doc]: /2022/01/31/zoe-covid-study.html
[zoe-data-page]: http://archive.today/2022.11.12-221530/https://health-study.joinzoe.com/data
[zoe-blog-local-14d]: http://archive.today/2022.11.14-170819/https://health-study.joinzoe.com/post/covid-rates-trends-changing-near-you

These quotations require further clarification.


## 2. How local estimates are smoothed

### 2.1 Watch-list estimates

ZOE have been generous with specific details, including the *un-averaged* local time series.  Remember, these are still derived from a [14-day average][files-doc].  The average is then [converted][from_incidence] to a prevalence, by smoothing it again over an even longer period.

[from_incidence]: https://github.com/sourcejedi/nova-covid/tree/main/prevalence_from_incidence

Since 2/14/22, ZOE has published a new set of [covid-public-data](files-doc) starting with "corrected_prevalence_region_trend_20220214.csv".  We can analyze and process these region_trend files.

Running the program [prevalence_digest.py][prevalence_digest_py] produces an output file "utla_8d_average.csv".  The end of these time series matches the *watch-list* estimates for the day.  We can also see an exact match with covid-public-data files like "utla_prevalence_map_20220214.csv".

[prevalence_digest_py]: https://github.com/sourcejedi/nova-covid/blob/efdd098/prevalence_digest.py

<strong>To reproduce the *watch-list* estimates, you have to use an 8-day average.  They are not averaged over a "week".</strong>

An 8-day average is also used in files like "lad_prevalence_map_20220214.csv", although in this case there is no public documentation to contradict.

This issue doesn't seem to create any other difficulties, beyond analyzing the region_trend files.  It doesn't affect any other ZOE numbers that I've seen.  The general problem is a [familiar one][off-by-one-error].

[off-by-one-error]: https://en.wikipedia.org/wiki/Off-by-one_error


## 2.2 Local trendlines

For the *local trendline*, we can produce the closest match using the 14-day average of LAD estimates.  [prevalence_digest.py][prevalence_digest_py] writes this average to "lad_14d_average.csv".  Limitations apply:

<strong>The *local trendline* in the app is shifted leftwards, and then adds estimates for an extra 6 days.  For example, the last day might only be average 8 days together, instead of 14.</strong>

I think this would be useful information.  It is not marked on the graph, or the documentation linked above.  The last 6 days of the local trendline will not be as smooth, and they will be more likely to be revised in future.

Note we can only compare our average with the app.  There is no corresponding file in covid-public-data.


## 3. How do ZOE define "not enough contributors"?

In the "\_prevalence_map\_" files, the "percentage" column (prevalence estimate) is left blank when "respondent" is less than 750.  The map on the website colours these UTLA's in grey.  When you click the area, it says "Not enough contributors".

The prevalence_digest.py output files include the same "respondent" value, except it is labelled as "respondent_count" instead, and is not rounded to the nearest whole number.

Sometimes ZOE consider it "enough" when the "respondent" column is exactly equal to 750.  Sometimes ZOE do not.  Presumably this happens when the average number of respondents was a fraction that rounded up to 750.

## Why does the map inside the app look different?

Inside the app, there is a map showing estimates for your LAD and neighbours.

Unfortunately, the app is not updating this map after the first time it fetches it.
