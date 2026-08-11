### Uninstallation Guide

This guide walks you through completely removing the **ModSec GeoIP FPS Reporter** plugin and its associated automation from your cPanel/WHM server. 

### Overview of the Process

The uninstallation workflow handles the following actions automatically: 

1. **Unregisters** the plugin from the WHM interface (cPanel AppConfig).
2. **Removes** the weekly automated cron job from the root crontab.
3. **Deletes** the plugin source files and directory from /usr/local/cpanel/whostmgr/docroot/cgi/whm_modsec_geoip.

### Running the Automated Uninstaller

1. **Navigate to the Repository Root**
Open an SSH session to your server as root and head to your repository directory: 

bash

cd /path/to/mod_security-CIST-Biopharma

Use code with caution.
2. **Make the Uninstaller Executable** 

bash

chmod +x uninstall.sh

Use code with caution.
3. **Execute the Script** 

bash

sudo ./uninstall.sh

Use code with caution.

### Manual Uninstallation Steps (Alternative)

If you have already deleted the repository directory and cannot run uninstall.sh, you can manually clean up the server components using these steps: 

### 1. Unregister from WHM

Run the following cPanel utility command to clear the application entry from the administration panel: 

bash

/usr/local/cpanel/bin/unregister_appconfig whm_modsec_geoip

Use code with caution.

### 2. Remove the Automated Task

Open the root crontab file: 

bash

crontab -e

Use code with caution.

Locate and delete the line referencing reporter.pl: 

text

0 0 * * 0 /usr/local/cpanel/whostmgr/docroot/cgi/whm_modsec_geoip/reporter.pl >/dev/null 2>&1

Use code with caution.

Save and exit the text editor to apply changes. 

### 3. Clear Remaining Files

Manually strip the application folder out of the cPanel document root hierarchy: 

bash

rm -rf /usr/local/cpanel/whostmgr/docroot/cgi/whm_modsec_geoip

Use code with caution.
