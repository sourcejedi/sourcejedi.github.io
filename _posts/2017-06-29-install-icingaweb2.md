---
layout: post
date:   2017-06-27 20:25:00 +0100
title:  "Installing Icinga Web 2 on Debian Stretch"
---

Icinga Web 2 is neat, and it's in Debian Stretch.  It's not trivial to install like the original Icinga cgi scripts ("Icinga Classic UI") was.  It's not that hard, but I had to make some notes.

# Install Icinga 2

Icinga comes ready to run, with an example configuration that monitors services on localhost.

    apt-get install icinga2

If you want to trigger re-checks etc., you will need to enable the `command` plugin:

    icinga2 feature enable command

The "checker", "mainlog", and "notification" plugins should already be enabled.  However, at one point in my testing they were not.  So you might want to check that.

    ls -l /etc/icinga2/features-enabled

# Install the web server

You will now be running a web server on your network (and you're about to install a PHP webapp).  Better keep up with those security updates!

Also, sending passwords (or commands) unprotected is a security problem.  Debian has scripts to help you set up self-signed SSL.  I haven't shown them here, but they can be surprisingly straightforward to use.

    apt-get install apache2

# Install the database server

The MariaDB package in Debian Stretch does not ask you to make up a password.  Instead, the Debian root user (or users of sudo) are simply granted access to mysql root.  Not *quite* as elegant as postgres, but it's a massive improvement.

    apt-get install mariadb-server

# Install Icinga's IDO for mariadb / mysql.

The install will prompt to enable IDO, and create a DB.  Say yes.
This might take a minute or so if you're not using an SSD.

    apt-get install icinga2-ido-mysql

The install does not actually enable IDO in icinga2, despite what it says.
[Bug report](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=865350).

    icinga2 feature enable ido-mysql
    systemctl restart icinga2

# Install Icinga Web 2

    apt-get install icingaweb2

# Prepare to run the wizard

Edit `/etc/php/7.0/apache2/php.ini`.
Uncomment `date.timezone` and set it.
Your current timezone is shown by `timedatectl`.  E.g. "Europe/London".

Create a database to store user passwords and settings.
If you need to protect against other users with access to the server,
change the password (IDENTIFIED BY 'icingaweb2') to be more secure.
(One lazy option would be to copy the password from IDO - see below).

    mysql

    CREATE DATABASE icingaweb2;
    GRANT ALL PRIVILEGES ON icingaweb2.* TO 'icingaweb2'@'localhost' IDENTIFIED BY 'icingaweb2';
    quit

    icingacli setup token create

# Run the wizard

Browse to `http://localhost/icingaweb2`.
You should see a red box saying "It appears that you did not configure Icinga Web 2 yet" etc.
Follow the link which starts the wizard.

I like to enable the "doc" module.

The password, database name etc which Debian generated for IDO,
can be found in `/etc/icinga2/features-available/ido-mysql.conf`.

# Reduce database privileges

This is a workaround for the wizard not accepting a pre-created database like it says it can, and then (if you bypass validation) failing to create the user it says it creates.

    mysql

    DROP USER 'icingaweb2'@'localhost';
    GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icingaweb2.* TO 'icingaweb2'@'localhost' IDENTIFIED BY 'icingaweb2';
    quit

