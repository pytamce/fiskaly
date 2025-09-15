# Ansible Playbook — Linux Server Setup for Ubuntu & RedHat

This repository contains an **Ansible playbook** to configure a set of Linux servers (Ubuntu and RedHa

---

## Playbook Overview

**File:** `linux-server-setup.yml`

### Tasks Performed

1. **Connect to all servers** defined in the inventory.
2. **Gather system facts** to detect OS family and installed packages.
3. **Update package repositories** and **upgrade all packages** for both Ubuntu and RedHat systems.
4. **Ubuntu-specific tasks:**

   * Install **Apache** web server.
   * Deploy a simple HTML page showing **"Hello world"** at `/var/www/html/index.html`.
   * Restart Apache to apply configuration changes.
5. **RedHat-specific tasks:**

   * Install **MariaDB** database server.
   * Ensure MariaDB service is **started and enabled** at boot.