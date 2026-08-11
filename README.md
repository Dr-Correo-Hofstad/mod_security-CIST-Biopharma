# mod_security-CIST-Biopharma
Because WHM plugins require root-level access and hook directly into the cPanel interface, the architecture is split into two components: a backend automation script (run via cron) that aggregates ModSecurity logs, performs geo-location, scrapes/formats the data, and emails the report, and a basic WHM interface wrapper to manage it.
