---
layout: page-narrow
title:  "Security part 3 - Passwords"
---

In part 1, we looked at your [email account]({% link 2026/03/30/online-security/1-email.md %}).

For some email providers, you need more than just a password.  People give the same password to different account systems.  Criminals can then target the weakest system, and steal the password.  In response, popular email providers use additional verification methods.

In part 2, we looked at securing your [device]({% link 2026/03/30/online-security/2-device.md %}).

Your device comes with a *password manager*.  This will let you save passwords for different accounts.  It is specifically designed to improve your security.

See also: [NCSC tips - Why you should use a password manager](https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/password-managers).


**Contents**

* toc
{:toc}


# Back up your passwords -- with apps and/or paper

When you enter a password in a website, your web browser should offer to save it.

If you remember the steps to secure your email, this section will look very similar:

1. Find your online password manager account
2. Make it easy to sign in
3. Set a strong, unique password
4. Make paper notes
5. Why using a password manager is safer

### 1. Find your online password manager account

Your web browser (or phone) should back up your saved passwords.  It uses an online account.  It might be the same account as your email.

Find the account for your browser or device.  For example:

**Web browser:**  
Microsoft Edge uses your Microsoft Account.

I prefer [Firefox](https://www.firefox.com) browser.  It’s less annoying, and more private.  It uses a Mozilla account.

**iPhone:**  
Uses Apple Passwords app (by default).  This uses your Apple account, aka iCloud Keychain.

**Android phone:**  
Comes with Google Password Manager.  This uses your Google account (like Gmail).

I install Firefox web browser on Android, for privacy reasons.  (Explanation: [Can I sync passwords in Chrome \- but not any other data?](https://android.stackexchange.com/questions/261909/sync-passwords-in-chrome-but-not-any-other-data))  You can still use Google Password Manager.

You may use alternative password apps.  Passwords can be transferred between all of the examples above, using a standard file format (CSV).

Avoid Samsung Pass, or any other software which cannot transfer passwords to a different system.

### 2. Make it easy to sign in

Your password manager account is a *primary account*, one which helps recover other online accounts.  Check the security settings for your password manager account.

* \[Google\] or \[Apple\] account - these were covered in [part 1][email].  Work through [part 1][email] for the password manager account, if you have not already.

* \[Microsoft\] account - this was also mentioned in [part 1][email].  Microsoft assume you have an alternate email account.  In [part 1][email], you secured your non-Microsoft email.  You should now re-apply [part 1][email] to secure your Microsoft account.  (If you want to avoid being dependent on the alternate email account, see my [extended notes][avoid-microsoft]).

[email]: {%link 2026/03/30/online-security/1-email.md %}
[avoid-microsoft]: https://docs.google.com/document/d/1NqAE3S8OUXGeBoIgqqnYi-5q3NS_t0R4j5OX-s9pvkw/edit?tab=t.0

* Some password managers do not necessarily need two-factor authentication, due to their encryption.  \[[1Password](https://docs.google.com/document/d/1cwtBgv9F7rfeNwwHQZsXgg_3ymZn--K5MTOkVUnSDBA/edit?tab=t.0#heading=h.xyen9zn7i31q)\]

* Some password managers may need a code from your email, when signing in on a new device.  \[[Bitwarden](https://docs.google.com/document/d/1cwtBgv9F7rfeNwwHQZsXgg_3ymZn--K5MTOkVUnSDBA/edit?tab=t.0#heading=h.954f7cihxpzy)\]  If you use Bitwarden, you should set up “two-step login” manually, which allows you to print or write down a "recovery code".

A good password manager will explain exactly how you sign in on a new device.  This helps you understand its security, and plan for [recovery](http://docs.google.com/document/d/1cwtBgv9F7rfeNwwHQZsXgg_3ymZn--K5MTOkVUnSDBA/edit?tab=t.0) at the same time.

Note: most online accounts are registered with an email address.  This applies equally to password managers.  Many password managers assume you have a working email address.

If you rely on your password manager to store your email password (or passkey, verification codes, etc), you could get locked out.  It is safest to keep an independent copy of your email sign-in details.

### 3. Set a strong, unique password

Most password managers use a password.  So you have a “primary” password: one that helps protect other passwords.

Most people have used the same password for more than one thing.  This is a problem.  Surprisingly often, one of the less secure websites or apps gets hacked, and leaks everyone’s password.

Set a password which is not used for any other online account.  It should not be easy to guess, e.g. from personal information.

NCSC recommends: use [three random words](https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/three-random-words).

### 4. Make paper notes

Make a note on paper, with all the information you need to recover your passwords.

**Caution**: When you restore your password manager from a backup, it may require more security details than for other apps.  Even when you use the same account as your email, it may need an additional code to unlock encrypted passwords.  See: [Back up your password manager or Authenticator app](https://docs.google.com/document/d/1cwtBgv9F7rfeNwwHQZsXgg_3ymZn--K5MTOkVUnSDBA/).

If you use both a laptop and a smartphone, for example, you will need paper notes to restore *both* devices.  Keep the notes together in one place.

Traditionally, many online accounts also treat your email and/or phone as primary accounts.  Many accounts allow resetting your password with a code sent to your email and/or phone number.  This is less convenient than a password manager.  But it is better than losing your account.

Keep notes for your email in the same place as well.  And ideally, for your mobile phone number too.

### 5. Why using a password manager is safer

You need a trusted system, that will let you save different passwords for different accounts.

When you sign in to a website, you are already trusting your web browser.  You already need your device to have good security.

A good password manager helps you improve security.  This doesn’t mean you can’t try a different option later.  Apple, Google, and Microsoft all support copying passwords to or from another system.  (I prefer the Firefox web browser, for example).

For Android phones, the password manager makes it easier when you need to replace the phone.  Many Android apps will not transfer your account automatically.

# Check for stolen passwords

The best password managers will check for known data breaches or weak passwords.  See e.g. instructions for [iPhone](https://support.apple.com/en-gb/guide/iphone/iphd5d8daf4f/ios) or [Mac](https://support.apple.com/en-gb/guide/passwords/mchl506a0d14/mac), [Google Chrome / Android](https://support.google.com/accounts/answer/9457609?hl=en), [Microsoft Edge](https://support.microsoft.com/en-us/topic/protect-your-online-accounts-using-password-monitor-6f660aae-65aa-476c-871a-7fe2bcb0c4c1), [1Password](https://support.1password.com/watchtower/).

If you are not sure what your password manager does, or you have not added all your accounts yet, there is also another way.  You could monitor for breaches based on your email address.  See [Mozilla Monitor (Firefox)](https://www.mozilla.org/en-US/products/monitor/) or [haveibeenpwned.com](https://haveibeenpwned.com).

If you believe a certain password has been leaked \- e.g. because it was used in too many places \- then it might also be confirmed here: [haveibeenpwned.com/Passwords](https://haveibeenpwned.com/Passwords).

# Set unique passwords

When you have a reliable way to record passwords, you can use different passwords for different accounts.

For example, your email account is important.  If you have re-used this password on any other account, now is the time to fix it!  Go back to your email account settings, and change the password.  It should be different from any other password.  It should not be easy to guess, e.g. from personal information.

Note: You might use an Orange password manager, and also an Orange email, for example.  These services may use a single online account, with a single password.  So you might have already set a unique password for your email.

When you have time available, look through the rest of your passwords.  Start with the online accounts that are most important for you, e.g.:

* Accounts for device backups, file storage, or photos  
* Online shopping or payment accounts  
* Social media

# Next steps

There is always more you could learn.  We have gone through most of the tips from the NCSC, but there is one final tip:

- [NCSC top tips - Backing up your data](https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/always-back-up-your-most-important-data)
