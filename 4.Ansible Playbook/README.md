# 📜 Ansible Playbook — Linux Server Setup for Ubuntu & RedHat

This repository contains an **Ansible playbook** called linux-server-setup.yml that is designed to manage a heterogeneous environment with both Ubuntu (Debian family) and RedHat servers.

It ensures the following:

* Systems are updated with the latest packages.
* Apache web server is installed, configured, and running on Ubuntu.
* MariaDB server is installed on RedHat.
* A simple "Hello world" webpage is deployed on Ubuntu.

---

## Files
```
linux-server-setup.yml
inventory.ini
```

---

## Design
1. Support for Multiple OS Families - to improve maintainability
    - uses ansible_os_family to distinguish between Debian and RedHat systems
    - avoids writing two separate playbooks and allows unified management

2. Package Management - to keep systems patched, which reduces security vulnerabilities and ensures software stability
    - ensures the latest security and feature updates are applied and upgraded for Debian and RedHat systems

## Execution Flow
- Update and upgrade all servers.
- Gather installed package facts.
- Install Apache on Ubuntu, MariaDB on RedHat.
- If Apache is installed on Ubuntu, deploy index.html.
- Ensure Apache is enabled and running on Ubuntu.

## Run playbook
```bash
ansible-playbook -i inventory.ini linux-server-setup.yml
```

