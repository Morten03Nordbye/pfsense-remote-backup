#!/bin/bash

# Configuration
PFSENSE_HOST="10.0.0.1"
PFSENSE_USER="Username"
PFSENSE_PASS="Password"
BACKUP_DIR="/mnt/nfs/pfsense-backup"
KEEP_DAYS=30
# Create a timestamped backup file name with hyphens between year, month, and day
# Format: pfsense-config-YYYY-MM-DD.xml
BACKUP_FILE="pfsense-config-$(date +%Y-%m-%d).xml"

# Copy the config.xml from pfSense to LinBast using sshpass
sshpass -p "${PFSENSE_PASS}" ssh "${PFSENSE_USER}@${PFSENSE_HOST}" "cat /cf/conf/config.xml" > "${BACKUP_DIR}/${BACKUP_FILE}"

# Check if there are backup files in the directory
FILE_COUNT=$(find "${BACKUP_DIR}" -name 'pfsense-config-*.xml' | wc -l)

# Cleanup old backups only if there are existing backup files
if [ "${FILE_COUNT}" -gt 0 ]; then
    find "${BACKUP_DIR}" -name 'pfsense-config-*.xml' -mtime +${KEEP_DAYS} -exec rm {} \;
fi
