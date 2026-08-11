#!/usr/bin/perl
use strict;
use warnings;
use Cpanel::Template;

print "Content-type: text/html\n\n";
print "<html><head><title>ModSec GeoIP Reporter</title></head><body>";
print "<h2>ModSecurity GeoIP to Fast People Search Plugin</h2>";
print "<p>Status: Active. Reports are compiled and emailed to <strong>hello\@cistbiopharma.com</strong> every week.</p>";
print "<form method='POST' action='run_now.cgi'><input type='submit' value='Trigger Report Now'/></form>";
print "</body></html>";
