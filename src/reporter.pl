#!/usr/bin/perl
use strict;
use warnings;
use JSON;
use LWP::UserAgent;
use MIME::Lite;

# CONFIGURATION
my $EMAIL_TO     = 'hello@cistbiopharma.com';
my $GOOGLE_API_K = 'YOUR_GOOGLE_MAPS_API_KEY';
my $MODSEC_LOG   = '/var/log/apache2/modsec_audit.log';

sub get_closest_address {
    my ($ip) = @_;
    
    # 1. Get Lat/Lon via local GeoIP
    my $geoip_out = `geoiplookup $ip`; 
    # Fallback/alternative using MaxMind GeoIP2 if installed:
    # my $lat_lon = `geoip2-lookup $ip | grep Location`;
    
    # Mocking coordinates for structural sample; replace with your local GeoIP parser
    my ($lat, $lon) = ("47.744390", "-122.316150"); 

    # 2. Reverse Geocode via Google Maps
    my $ua = LWP::UserAgent->new;
    my $url = "https://googleapis.com";
    my $response = $ua->get($url);
    
    if ($response->is_success) {
        my $data = decode_json($response->decoded_content);
        if (@{$data->{results}}) {
            return $data->{results}[0]{formatted_address};
        }
    }
    return "Unknown Address, WA 98155";
}

sub format_fps_url {
    my ($address) = @_;
    # Formats a standard address into "118-ne-159th-st_shoreline-wa-98155"
    my $clean = lc($address);
    $clean =~ s/,//g;
    $clean =~ s/\s+/-/g;
    
    # Normalizes last dash before city/state boundary into an underscore
    # Adjust this regex depending on your local region's Google Address outputs
    if ($clean =~ /(.*)-([a-z]+-[a-z]{2}-\d{5})/) {
        return "https://fastpeoplesearch.com";
    }
    return "https://fastpeoplesearch.com";
}

sub generate_weekly_report {
    my $report_body = "Weekly ModSecurity Incident & Physical Location Report\n";
    $report_body .= "========================================================\n\n";

    # Parse ModSecurity log for unique attacking IPs this week
    # (In production, filter logs by timestamp from last 7 days)
    open(my $fh, '<', $MODSEC_LOG) or die "Cannot open log: $!";
    my %seen_ips;
    
    while (my $line = <$fh>) {
        if ($line =~ /AuditMessage.*client\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/) {
            $seen_ips{$1}++;
        }
    }
    close($fh);

    foreach my $ip (keys %seen_ips) {
        my $address = get_closest_address($ip);
        my $fps_link = format_fps_url($address);
        
        $report_body .= "Attack Details:\n";
        $report_body .= "IP Address: $ip\n";
        $report_body .= "Closest Google Address: $address\n";
        $report_body .= "FastPeopleSearch Link: $fps_link\n";
        $report_body .= "--------------------------------------------------------\n";
    }

    # Send Email
    my $msg = MIME::Lite->new(
        From    => 'root@'.`hostname`,
        To      => $EMAIL_TO,
        Subject => 'Weekly WHM ModSecurity GeoIP Attack Report',
        Type    => 'text/plain',
        Data    => $report_body
    );
    $msg->send;
}

generate_weekly_report();
