# Terraform Modules

This repository the modules I'm creating while using terraform.

## Modules

- [bg-poc](#bg-poc)

###bg-poc

Simple Blue/Green Green deployment poc, for now, we are just launching a haproxy for balancing and 2 nginx instances for the web app. The objective is to pass just a small % to one of the web instances, based on some header.
