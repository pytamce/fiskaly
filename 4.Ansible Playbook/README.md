# 📜 Ansible Playbook — Linux Server Setup for Ubuntu & RedHat

This repository contains an **Ansible playbook** to configure a set of Linux servers (Ubuntu and RedHa

---

## Task
Write an Ansible playbook that does the following
* Connect to the list of Linux servers where both RedHat and Ubuntu distributions can installed
* Gather facts about systems
* Update repositories for all systems
* Upgrade servers with the latest packages available for the system version
* Make sure that Apache webserver is present on Ubuntu servers only
* If system is Ubuntu and Apache is installed, launch a simple configuration showing html document with, again, “Hello world”
* Once the Apache’s configuration file has been updated - Apache process should be restarted/reloaded to pick up the changes in configuration
* Make sure that MariaDB is installed on RedHat servers only


---

## Files
```
linux-server-setup.yml
```
