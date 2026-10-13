# Nested Virtualization & Cascaded Load Balancing Infrastructure

## 📌 Project Overview
This repository contains the Infrastructure as Code (IaC) configurations, network definitions, and automation scripts for a complex, multi-tier nested virtualization project. The environment simulates a highly available distributed architecture built entirely from scratch using KVM/Libvirt and Apache2.

## 🏗️ Architecture & Topology
The infrastructure is structured in a tree topology (cascaded virtualization), demonstrating advanced routing and resource management:

* **Level 0 (Physical Host):** The main hypervisor providing the nested virtualization capabilities.
* **Level 1 (Master Node):** `master-vm` (192.168.122.19) - Acts as the primary Gateway, NAT Router, and Root Load Balancer.
* **Level 2 (Parent Nodes):** `vm1` (192.168.123.191) & `vm2` (192.168.123.37) - Function as secondary Load Balancers and logical group managers.
* **Level 3 (Child Nodes):** `vm1-1` (192.168.100.24), `vm1-2` (192.168.100.219), `vm2-1` (192.168.101.178), `vm2-2` (192.168.101.244) - The underlying web servers hosting the end-user content.

## 🚀 Technologies & Concepts Applied
* **Hypervisor:** Linux KVM / QEMU / Libvirt with Nested Virtualization enabled.
* **Networking & Security:** Advanced `iptables` rules (DNAT, Port Forwarding, Masquerading) to manage traffic across multiple isolated subnets.
* **Load Balancing:** Apache2 (`mod_proxy`, `mod_proxy_balancer`) configured in a cascaded topology to distribute web traffic efficiently.
* **Automation:** Custom Bash scripting (`scatter.sh`, `gather.sh`) utilizing SSH key-based authentication for seamless lateral file distribution across the multi-tier nodes.
* **Infrastructure as Code:** All virtual machine hardware specifications and network topologies are exported and version-controlled as Libvirt XML definitions.

## 📁 Repository Structure
* `/libvirt-configs/` - Contains the XML definitions of the virtual machines (`master.xml`, `vm1.xml`, etc.) and the virtual network (`network-default.xml`).
* `/apache-configs/` - Contains the VirtualHost and cluster proxy configurations for the Master and Parent nodes.
* `/scripts/` - Custom Bash scripts for automated file deployment and network routing setups.

## 💡 Key Learnings & Troubleshooting
Throughout this project, I successfully managed complex routing loops, debugged Libvirt PID and strict storage allocation issues, and implemented persistent iptables rules to ensure seamless communication across nested NAT networks.
