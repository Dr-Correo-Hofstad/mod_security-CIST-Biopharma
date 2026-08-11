#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root."
  exit 1
fi

# Define paths
SRC_DIR="./src"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/whm_modsec_geoip"
CONF_FILE="whm_modsec_geoip.conf"
REPORTER_SCRIPT="reporter.pl"
INDEX_CGI="index.cgi"

echo "=== Starting ModSec GeoIP FPS Reporter Installation ==="

# 1. Create target directory if it doesn't exist
if [ ! -d "$PLUGIN_DIR" ]; then
    echo "Creating directory: $PLUGIN_DIR"
    mkdir -p "$PLUGIN_DIR"
fi

# 2. Verify source files exist and copy them
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory '$SRC_DIR' not found. Run this from the repository root."
    exit 1
fi

echo "Copying source files to WHM extension directory..."
cp -r "$SRC_DIR"/* "$PLUGIN_DIR/"

# 3. Set strict, secure ownership and permissions
echo "Setting permissions..."
chown -R root:root "$PLUGIN_DIR"
chmod 755 "$PLUGIN_DIR"

# Make CGI scripts and backend automation executable
if [ -f "$PLUGIN_DIR/$REPORTER_SCRIPT" ]; then chmod 700 "$PLUGIN_DIR/$REPORTER_SCRIPT"; fi
if [ -f "$PLUGIN_DIR/$INDEX_CGI" ]; then chmod 755 "$PLUGIN_DIR/$INDEX_CGI"; fi

# 4. Register the Application Configuration with WHM
if [ -f "$PLUGIN_DIR/$CONF_FILE" ]; then
    echo "Registering plugin with cPanel AppConfig..."
    /usr/local/cpanel/bin/register_appconfig "$PLUGIN_DIR/$CONF_FILE"
else
    echo "Warning: $CONF_FILE not found in src. Skipping cPanel application registration."
fi

# 5. Set up the weekly Cron Job for automation
CRON_JOB="0 0 * * 0 $PLUGIN_DIR/$REPORTER_SCRIPT >/dev/null 2>&1"
( crontab -l 2>/dev/null | grep -F "$REPORTER_SCRIPT" ) \
    && echo "Cron job already exists. Skipping..." \
    || ( crontab -l 2>/dev/null; echo "$CRON_JOB" ) | crontab -
echo "Weekly cron job scheduled (Sundays at midnight)."

echo "=== Installation Complete ==="
echo "You can now access the plugin under the 'Plugins' menu in your WHM interface."
