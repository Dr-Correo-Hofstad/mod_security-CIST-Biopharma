### Installation Guide

This guide walks you through installing the **ModSec GeoIP FPS Reporter** plugin on your cPanel/WHM server. 

### Prerequisites

Before running the installer, ensure your server meets the following requirements: 

* **Root Access**: You must have root SSH privileges on the target cPanel server.
* **ModSecurity**: Auditing logs must be active and saving to /var/log/apache2/modsec_audit.log (or your environment's custom path).
* **System Packages**: The geoiplookup tool must be available on the system path.
* **Google Maps API Key**: A valid Geocoding API key from Google Cloud Console.

### Step-by-Step Installation

1. **Clone or Download the Repository**
Place the project files on your WHM server via SSH.
2. **Navigate to the Repository Root** 

bash

cd /path/to/mod_security-CIST-Biopharma

Use code with caution.
3. **Configure API Credentials**
Open src/reporter.pl in your preferred text editor and replace YOUR_GOOGLE_MAPS_API_KEY with your actual Google Maps Geocoding API key.
4. **Make the Installer Executable** 

bash

chmod +x install.sh

Use code with caution.
5. **Run the Installer as Root** 

bash

sudo ./install.sh

Use code with caution.

### Post-Installation Verification

* **WHM Interface**: Log into your WHM panel, navigate to the **Plugins** section in the left sidebar, and click on **ModSec GeoIP FPS Reporter**.
* **Cron Job**: Verify the automation task was successfully added by listing the root crontab: 

bash

crontab -l | grep reporter.pl

Use code with caution.
