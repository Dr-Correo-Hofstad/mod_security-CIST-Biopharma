### Configuration & Troubleshooting Guide

The ModSec GeoIP FPS Reporter relies on server paths and API formats matching your infrastructure. This document explains how to customize and maintain the script. 

### Custom Customizations

### Changing Log Paths

If your cPanel server uses a custom reverse proxy setup (like Nginx caching in front of Apache) or CloudLinux, your ModSecurity logs might be located in a non-standard directory.
To adjust this, modify the $MODSEC_LOG variable near the top of src/reporter.pl: 

perl

my $MODSEC_LOG = '/var/log/apache2/modsec_audit.log'; # Change to your path

Use code with caution.

### Changing the Target Email

To alter who receives the weekly structural intelligence logs, modify the email declaration inside src/reporter.pl: 

perl

my $EMAIL_TO = 'hello@cistbiopharma.com';

Use code with caution.

### Troubleshooting & Validations

### Testing the Email Delivery Backend

If you are not receiving reports, verify that your server has a functional local MTA (like Exim, which comes standard on cPanel) and that the MIME::Lite Perl library is operating correctly. You can trigger a manual processing run using: 

bash

perl /usr/local/cpanel/whostmgr/docroot/cgi/whm_modsec_geoip/reporter.pl

Use code with caution.

### Checking Local GeoIP Lookup

Ensure your underlying system can successfully map IPs to locations by running a manual terminal probe: 

bash

geoiplookup 8.8.8.8

Use code with caution.

If this command is missing, install the legacy geolocation dataset or rewrite the backend subroutine to interface with your preferred local MaxMind GeoIP2 .mmdb lookup tool.
