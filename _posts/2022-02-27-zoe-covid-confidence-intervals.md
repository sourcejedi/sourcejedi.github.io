---
layout: post
date:   2022-02-27
title:  "ZOE Covid Study - confidence intervals"
---

The "v1" [ZOE paper][ZOE-method] used 95% [confidence intervals][wiki-CI], with a specific definition.

This post is a reminder to myself.  As ZOE have revised their methods, they showed different intervals over time and different types of graphs.  The new intervals were not defined, so we must not assume they have exactly the same meaning.

In one case, there is enough information to suggest the interval was wrong.

In another case, ZOE reasonably explained different confidence intervals as showing an improvement.  However, when there is no explanation, it is not safe to assume we can always compare different intervals.

(Also, I once said ZOE's current range "should" still use a 95% confidence interval.  I needed to correct that, or at least clarify it.  ZOE *ought* to still use a 95% confidence interval, because they didn't announce a change.)

[wiki-CI]: https://en.wikipedia.org/wiki/Confidence_intervals
[ZOE-method]: /2022/02/02/zoe-covid-study-part-2-methods.html


* TOC
{:toc}

## 1. Timeline

<!-- TODO. Putting in the numbers would make this more useful for users of screen readers. And anyone for whom this stuff doesn't jump out at. Like it didn't for me, for too long :-). -->

<!-- some comments illustrate how to verify -->

2021-05-12: [ZOE method v3][ZOE-v3]. Incidence is now estimated separately in vaccinated and unvaccinated people. These are added together to give total UK incidence.

2021-05-27: The label "95% confidence interval" was removed from all graphs. Official releases no longer declare how the confidence intervals work.

Up to the current day, [internal website files][ZOE-web-assets] still label the incidence intervals as 95% upper and lower limits.  These include ["incidence table.csv"][incidence-table-csv-capture].  However, if effectively no-one is looking at this, there is no reason to expect it to be kept up to date.

<!-- compare reports for date and date - 1 -->

2021-06-09: A graph was added to show incidence by vaccination status. The absolute difference between upper and lower confidence intervals is significantly higher for unvaccinated cases, than it is for the graph showing total UK cases.

I think there is a mistake here, in the interval on the graph of total UK cases. I think it is calculated based on the number of tests overall, instead of looking at the two subsamples separately.  I made a graph of the interval as a percentage of the central estimate, and it appears to be identical between v2 and v3.

[[Graphs]](#v2-to-v3)

<!-- Total UK incidence is not always graphed in the daily report, but it is in the "for app users only" page that links to the report. I've mostly been checking incidence_*.csv.

Contemporary side-by-side comparison: https://twitter.com/sourcejedi/status/1408433707686498305 -->

2021-07-17: The changelog says "Removed incidence graph by vaccination status from the report as there are very few unvaccinated users in the infection survey, <em>the Confidence Intervals are very wide</em> and the trend for unvaccinated people is no longer representative."  The inconsistency in confidence intervals was also quite large at this point.

[[Graphs]](#2021-07-16)

2021-07-21: [ZOE method v4][ZOE-v4]. The daily report starts showing incidence by vaccination status again. This time, the intervals for total UK incidence appear wider than the intervals for unvaccinated and vaccinated incidence put together. This is inconsistent again, just the other way round.

The announcement of method v4 includes a graph comparing old and new estimates. The intervals for the new estimate on this graph, are different from the UK total graph in the report. They might be consistent with the new graph by vaccination status.

Similarly, the intervals for the old estimate on the comparison graph are different from the old UK total graphs. They are <em>closer</em> to being consistent with the older "by vaccination" graphs, though still visibly inconsistent. It would require some historical revisions.

The new graphs by vaccination status have narrower intervals than the older graphs by vaccination status. If the two intervals are calculated in the same way, this is the result I would expect. Method v4 increased the number of tests several-fold, in part because it went back to including LFT's.

[[Graphs]](#v3-to-v4)

2021-08-27: The graph by vaccination status is changed, to show incidence among the fully vaccinated v.s. total incidence.  The current confidence intervals are similar to the dedicated graph of total UK incidence, but not identical.

2021-10-06: Just before method v5. The confidence intervals remain similar but not identical.

<!-- TODO: does the "old" CI in the v5 blog match either the vaccine or total UK graph? -->

2021-10-07: [ZOE method v5][ZOE-v5]. The purpose of this change is to narrow the confidence interval, making the estimate more sustainable "with unvaccinated users disappearing from our study". This is illustrated with a graph. The announcement is unclear how this result is achieved.

2021-10-10: Method v5 is stabilized by now, after a little back-and-forth. There is still a graph with incidence among the fully vaccinated, v.s. total incidence. On this graph, the confidence intervals for total incidence are less than half as wide as those on the dedicated graph of total UK incidence.

2021-12-07: I asked ZOE about this last inconsistency.  ZOE forwarded it to their team of data scientists ["to confirm this is correct"][ZOE-CI-email].  I have not received any further response.


[ZOE-web-assets]: https://covid-assets.joinzoe.com/
[incidence-table-csv-capture]: https://drive.google.com/drive/folders/1O9vUWKufI3KfaGtNvKjBTKxHq6yNcyfX

[ZOE-v3]: /2022/02/02/zoe-covid-study-part-2-methods.html#2021-05-12-v3-covid-estimates-revised-after-change-to-methodology
[ZOE-v4]: /2022/02/02/zoe-covid-study-part-2-methods.html#2021-07-21-v4-covid-estimates-updated-as-more-people-are-being-vaccinated
[ZOE-v5]: /2022/02/02/zoe-covid-study-part-2-methods.html#2021-10-07-v5-future-proofing-our-covid-estimates

[ZOE-CI-email]: /assets/for-post/2022-02-zoe-covid-study-confidence-intervals/ZOE-CI-email.html


## 2. Graphs

### v2 to v3

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/v2v3.png">

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/v2v3-ci.png">

### 2021-07-16

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/2021-06-16-by-vaccination.png">

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/2021-06-16-UK.png">

### v3 to v4

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/2021-07-20-UK.png">

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/v3v4.png">

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/2021-07-21-UK.png">

<img src="/assets/for-post/2022-02-zoe-covid-study-confidence-intervals/2021-07-21-by-vaccination.png">
