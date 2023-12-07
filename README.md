pfSense Configuration Backup Script

pfSense Configuration Backup Script
===================================

Overview
--------

This script automates the backup of the pfSense firewall configuration (`config.xml`). It copies the configuration file from a pfSense system to a specified backup directory on a Linux host. The backups are timestamped for easy identification and management.

Features
--------

*   **Automated Backup**: Facilitates daily backups of the pfSense configuration.
*   **Timestamped Filenames**: Backup files are named with the date of the backup for easy identification.
*   **Backup Retention**: Automatically deletes older backups after a specified retention period.

Prerequisites
-------------

*   A Linux host with network access to the pfSense firewall.
*   NFS share mounted on the Linux host for storing the backup files.
*   `sshpass` installed on the Linux host for password-based SSH login (if SSH keys are not used).

Installation
------------

### Step 1: Mounting the NFS Share

Ensure the NFS share is mounted on the Linux host. Add the following line to `/etc/fstab`:

10.0.0.2:/volume1/share /mnt/nfs nfs rw 0 0

Then, execute:

    mkdir -p /mnt/nfs
    mount -a

### Step 2: Script Setup

1.  Download the `pfsense_backup.sh` script from this repository.
2.  Place the script in a suitable directory on the Linux host, e.g., `/home/user/scripts/`.
3.  Make the script executable:
    
        chmod +x /home/user/scripts/pfsense_backup.sh
    
4.  Edit the script to configure the pfSense host details and backup directory.

### Step 3: Crontab Configuration

1.  Open the crontab for editing:
    
        crontab -e
    
2.  Add the following line to schedule the backup script to run daily at 2 AM:
    
        0 2 * * * /home/user/scripts/pfsense_backup.sh
    

Usage
-----

Once set up, the script will run automatically according to the crontab schedule. Backup files will be stored in the NFS-mounted directory `/mnt/nfs/pfsense-backup`.

Backup File Naming Convention
-----------------------------

Backup files are named in the format `pfsense-config-YYYY-MM-DD.xml`, where `YYYY-MM-DD` is the date of the backup.

Backup Retention
----------------

The script is configured to retain backups for a specified number of days (default is 30 days). Backups older than this period are automatically deleted.

Restoring a Backup
------------------

To restore a backup, copy the desired `config.xml` file back to the pfSense system and apply it via the pfSense web interface or restore it directly if you have console access.

Security Note
-------------

If using `sshpass` for password-based SSH login, ensure that the script file permissions are set to restrict access, as it contains sensitive information.

Contributing
------------

Contributions to this project are welcome. Please fork the repository and submit a pull request with your changes.


\[Specify License Here\]
