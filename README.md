### ModSec GeoIP FPS Reporter

An automation-focused WHM (Web Host Manager) plugin designed to parse ModSecurity audit logs, cross-reference malicious IP activity with local GeoIP datasets and the Google Maps Geocoding API, and deliver formatted reporting direct to your security team. 

### Overview

Because WHM plugins require root-level access and hook directly into the cPanel administrative ecosystem, the architecture is split cleanly into two parts: 

1. **Backend Automation (src/reporter.pl)**: A core Perl script run weekly via a system daemon (cron) that aggregates log data, converts coordinates to addresses, generates normalized Fast People Search formatting, and emails reports.
2. **WHM User Interface Wrapper (src/index.cgi & src/whm_modsec_geoip.conf)**: A standard application dashboard embedded safely within the WHM admin panel for status confirmation and quick manual triggers.

### Repository Structure

text

├── docs/
│   ├── configuration.md   # Advanced environment paths & API debugging
│   └── install.md         # Deployment requirements & terminal steps
├── src/
│   ├── index.cgi          # The WHM user interface index page
│   ├── reporter.pl        # Core parsing, API formatting, and email delivery core
│   └── whm_modsec_geoip.conf # cPanel Application Registration configuration
├── LICENSE                # BSL-1.0 Software License
├── install.sh             # Master automated deployment bash script
└── README.md              # This overview file

Use code with caution.

### Getting Started

1. **Deploy:** Pull this repository down onto your active cPanel/WHM server using an elevated shell environment.
2. **Setup:** Provide your operational credentials and Google Geocoding keys directly to the main script profile.
3. **Execute:** Run the root installer tool to automatically handle paths, set file permissions, bind with the WHM panel engine, and schedule the background cron sequence.

For specific steps, terminal scripts, and exact environment configurations, consult the specialized guides: 

* Refer to [docs/install.md](docs/install.md) for quick deployment instructions.
* Refer to [docs/configuration.md](docs/configuration.md) for custom log pathways and diagnostic practices.

### License

This project is licensed under the BSL-1.0 License. See the LICENSE file for full terms.
