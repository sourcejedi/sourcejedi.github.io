---
layout: post-narrow
title:  "Do Microsoft accounts require a recovery email address or a mobile number?"
---

_Shortly after I finished writing up their security and recovery system, Microsoft decided to [change it][SMS-phase-out].  So I went back again and checked how everything works.  These are my test results._

[SMS-phase-out]: https://support.microsoft.com/en-us/account-billing/microsoft-to-stop-sending-sms-codes-for-personal-accounts-31b80825-bdd0-4bf2-926b-dca3c35ee4c1

A personal Microsoft account requires at least one email address (or phone number).  If you don't have an existing email address, you can create one on Outlook.com.

When you create an Outlook.com account, it tends not to ask for any other contact information.  However, Microsoft will require you to add alternative contact info later on.

Video example: [How To Create a Microsoft Account][YT-AldoJames-Create-MSA], by Aldo Jones (2025-12-30).

[YT-AldoJames-Create-MSA]: https://www.youtube.com/watch?v=iS6WC9qeJTQ

At the end of Aldo's video, he opens the Privacy section in Microsoft account.  Before he can actually use the Privacy section, he is required to add contact info.

The same requirement applies to the "Manage how I sign in" page, in the Security section.

You can pass this requirement by adding a recovery email address, or using a non-Microsoft email when you create your account.


**Contents**

* TOC
{:toc}


## Can you use a Windows PC without adding contact information?

It appears possible to avoid the requirement above, if you follow these steps:

1. Create an Outlook.com account during Windows setup, or in the Settings app.
2. Use this account to sign in to Windows.
3. Open the _Edge_ browser app (non-private mode).
4. Open [account.microsoft.com][MSA]

[MSA]: https://account.microsoft.com/account

In other words, this allowed me to open the "Manage how I sign in" and Privacy pages, without adding alternative contact info.

Aldo could not do this, because he used a Mac instead of a Windows PC.

However, adding contact info is still required before you can use certain security features (below).

Microsoft will remind you to add contact info.  If you skip past this, it may also prevent you from recovering your data, when your PC breaks, or needs to be repaired.  (Using OneDrive backup, and Bitlocker recovery key backup, respectively).


## How can they force me to add contact information?

Microsoft can require you to add contact info when you use a security feature.

This can happen when you sign in on a new device.  I saw this happen, a few days after I created my test account.

Currently, contact info is also required to turn on two-step verification - a top tip from [Cyber Aware][cyber-aware-2sv] experts - or to "go passwordless", as per [Microsoft security guidance][MSA-secure].

[cyber-aware-2sv]:    https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/activate-2-step-verification-on-your-email
[MSA-secure]:    https://support.microsoft.com/en-us/account-billing/how-to-help-keep-your-microsoft-account-secure-628538c2-7006-33bb-5ef4-c917657362b9

Microsoft understands this could raise concerns.  In certain cases, Microsoft lets you skip the requirement temporarily.  You can repeat this for up to seven days.  After seven days, when you sign in on a new device, you will need to add contact info.

You can be required to add contact info due to events beyond your control.  For example, network changes can affect how Microsoft detects your location.  This can trigger the security system (below).

References:

* [Help us secure your account](https://support.microsoft.com/en-us/account-billing/help-us-secure-your-account-548970dd-45df-49ca-a21c-c87e47bd421c) -- "If you see a message that says 'Let's protect your account' or 'Help us secure your account', it's because we need you to add some information to your account..."

* [Troubleshoot Microsoft verification code issues](https://support.microsoft.com/en-us/account-billing/troubleshoot-microsoft-verification-code-issues-409090c4-92b5-42b9-8ae6-bcc97e62fc48)  -- Under "How to fix "make sure you can receive a security code" when signing in to my Microsoft account."


## What do they do with my contact information?

> When we detect a sign-in attempt from a new location or device, we add a second layer of protection and send you an email message and SMS alert.

> Everyone with a Microsoft account needs to have up-to-date security contact info, which is an alternate email address or phone number where you can get security codes.

> When you enter the code you received, we know that you're really you and we can get you back into your Microsoft account.

Source: [How to access Outlook.com when traveling][outlook-travel].  [Archived][outlook-travel-saved] from the original on 2026-02-24.

[outlook-travel]: https://support.microsoft.com/en-us/office/how-to-access-outlook-com-when-traveling-c44f16da-7156-4890-853c-286aafeda87e

[outlook-travel-saved]: https://web.archive.org/web/20260224050228/https://support.microsoft.com/en-us/office/how-to-access-outlook-com-when-traveling-c44f16da-7156-4890-853c-286aafeda87e

See also (more recently updated): [What happens if there's an unusual sign-in to your account][microsoft-alert].

[microsoft-alert]: https://support.microsoft.com/en-us/account-billing/what-happens-if-there-s-an-unusual-sign-in-to-your-account-eba43e04-d348-b914-1e95-fb5052d3d8f0

When I add security contact info to an existing account, Microsoft says "we won't use this to spam you—just to keep your account more secure".  I tested this using "Manage how I sign in", in the Security section.

Once you add contact info, it is not possible to remove it unless you add (and verify) alternative contact info.

You cannot sign in to an Outlook.com address by sending a code to that address.  Even when I am signed in on another device, there is no option to do this.


## What types of contact information can I use?

If you create a Microsoft account using an existing email address, your address is automatically used as contact info.

In addition, you can add one or more alternative email addresses as contact info.

Microsoft say you can no longer add a phone number.  If you have already added a mobile number to your account, you can still use that number at the moment.  However, Microsoft is phasing out the use of phone numbers.

Sources:

* [Microsoft account security info & verification codes](https://support.microsoft.com/en-us/account-billing/microsoft-account-security-info-verification-codes-bf2505ca-cae5-c5b4-77d1-69d3343a5452)

* [Microsoft to stop sending SMS codes for personal accounts](https://support.microsoft.com/en-us/account-billing/microsoft-to-stop-sending-sms-codes-for-personal-accounts-31b80825-bdd0-4bf2-926b-dca3c35ee4c1)


## What if I don't have another email address?

If you use an Android phone, you should already have a Google account.  You can [add a Gmail address][gmail-create] to an existing Google account.

You can also create a new Gmail account, for free.

If you use an iPhone, you could create an [iCloud Mail][icloud-mail-create] address.

Microsoft also say you can use the email address of a trusted contact.  This could be your partner, or a family member.

[gmail-create]:    https://support.google.com/accounts/answer/76194
[icloud-mail-create]:    https://support.apple.com/en-gb/guide/icloud/mmdd8d1c5c/1.0/icloud/1.0


## Can I use Microsoft Authenticator as the contact information for my account?

No.  At the moment, adding the Microsoft Authenticator app does not remove the requirement for an recovery email address (or mobile number).

If you try to sign in to Authenticator, you are required to add contact info.  The same thing happens if you turn on two-step verification, or "go passwordless".

(Also, when I tried to add "Use an app" on the "Manage how I sign in" page, without having added contact information, it simply refreshed the page without doing anything.  So I don't expect you can do that, either.)

Once I had added an alternative email address to my test account, I was not able to remove it.  It said that I needed to add a new alternative email address first.  There was no other alternative.  Even though I had added Microsoft Authenticator to my account (as well as a non-Microsoft authenticator app, and a passkey).

I simulated losing the alternative email address for this test account, and recovering the account using a saved "Microsoft Account Recovery Code".  I was required to add a new alternative email address.  There was no other alternative.

At the end of Aldo's 2025 video (above), the Privacy page required him to add an alternative email address, or a mobile number.  There were no other options.


## I don't want to add contact information.  Could I write down a Recovery Code instead?

Based on my testing, this is not possible.

I have tried generating a Microsoft Account Recovery Code (in "Manage how I sign in") without adding contact info.  This failed, saying there was a "temporary problem".

On a different account which does have contact information, there was no problem generating a recovery code.


## Why is contact information required by Microsoft account (even though I have an Outlook.com email)?

Microsoft need a way to send different types of security alert.  Email works very well for this.

If someone hacked your Outlook.com email, they could delete any alerts that were sent to it.  So you need to have an alternative email address.

From a user's point of view, SMS may work equally well.  However, Microsoft say SMS security has been slower to improve.  There are also cost issues, which include criminals using premium numbers.

More specifically, a key part of the security system is based on alerts.  You can see the process here: [What does “Security info change is still pending” mean?](https://support.microsoft.com/en-us/account-billing/what-does-security-info-change-is-still-pending-mean-cbd0f64f-02d9-45d2-90c3-2375e5a72e52)


## Sidenote: What do they do with my *main* email address?

When permitted by local law, your main email address might be used to send "offers" from Microsoft, and/or shared with "Microsoft partners", unless you opt out.

Microsoft shows one or more options for this, during the account creation process.  When I tested (on Windows, in 2026) I saw one checkbox for this, which was checked by default.  Aldo's video (above) shows a different case.

In the EU or UK, for example, it could be illegal to share contact info on an "opt-out" basis.  As far as I know, Microsoft do not break this law in the EU.

If you want to know more about your settings, you could use the Microsoft Privacy Request form.  Microsoft explained that, as of 31/05/2025, it might not be possible to know your current settings without asking them.  This is because the online system does not always mean what it appears to say.  I look forward to reading future updates from Microsoft.

See: [Why does my Outlook.com account say "Share or use my details with Microsoft Partners"?](https://webapps.stackexchange.com/questions/181341/why-does-my-outlook-com-account-say-share-or-use-my-details-with-microsoft-part)


<!-- CUT TEXT

Note: in this case, Edge kept me permanently signed in to the Microsoft account website.

It seems possible to start using Microsoft Windows without adding contact info to your account.  However, at some point, if you want to keep using the same account on a new PC, phone, or other device, you may be forced to add contact info.

Contact info is still required when you use certain features:

 * Turn on two-step verification (in "Manage how I sign in").
 * "Go passwordless" (in "Manage how I sign in").
 * Sign in to the Microsoft Authenticator app.
-->
