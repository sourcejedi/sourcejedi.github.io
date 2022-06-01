---
layout: post
date: 2022-06-01
title: ZOE Covid Study - possible mistake in the "hotspots" paper
---

I posted a comment on PubPeer, with [full details, graphs, and code](https://pubpeer.com/publications/3C823DD588CE2A33BE78AD80E9CCDD).

It might not be the easiest to read.  Here are the main points:

---
<br>

ZOE Covid Study publish daily estimates of incidence ("new cases"), based on app users reporting new symptoms and test results.  They also convert it to a prevalence estimate ("active cases").  This conversion requires a recovery model.  The recovery model tells you how long it takes for a new cases to recover, and stop being active cases.

They explain this in a scientific paper, including specific values for a recovery model.  I tried applying this model to ZOE incidence estimates.  However, the resulting prevalence is about 14% lower than ZOE daily prevalence estimates.

Have ZOE simply changed the recovery model?  No.  The paper shows graphs of incidence and prevalence for England.  The prevalence graph matches ZOE daily prevalence estimates; it is not 14% lower.  The incidence graph also matches ZOE daily incidence estimates.

Did I just make a mistake in my calculation?  I don't think so.  I re-ran my calculations on a test case, where there is just one day with 100 new cases.  The result is a curve which shows an upside-down version of the recovery model.  If there are 90 active cases on day 2, then 10% of cases are recovering by day 2.  My curve matched the graph of the recovery model shown in the paper.

I think there is a mistake in the paper.  I think the paper probably shows the wrong recovery model.

I also worked out the recovery model ZOE use for daily prevalence estimates.

If the paper showed this alternative recovery model, there would be no problem with my calculation.  The words "most users recover in 7–10 days" would need changing to say "7-11 days".  The appendix that defines the recovery model might need changing as well.  But as far as I know, none of this would change the main points of the paper.
