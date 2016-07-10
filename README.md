# Terraform Modules

This repository the modules I'm creating while using terraform.

## Modules

- [aws-elk](#aws-elk)
- [bg-poc](#bg-poc)

###aws-elk

[ELK](https://www.elastic.co/webinars/introduction-elk-stack) is a stack used to centralize and analyse logs. It is compose of:
- ElasticSearch
- Kibana
- LogStash

This module uses the ElasticSearch service of AWS, the Kibana plugin, and creates an instance with a LogStash Docker container.

###bg-poc

Simple Blue/Green Green deployment poc, for now, we are just launching a haproxy for balancing and 2 nginx instances for the web app. The objective is to pass just a small % to one of the web instances, based on some header.
