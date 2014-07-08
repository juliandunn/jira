Description
===========

Installs [Atlassian JIRA](https://www.atlassian.com/software/jira/overview), a popular project-management and ticketing system for software project teams.

Requirements
============

## Platforms

* CentOS 6/RHEL6

This cookbook might work on CentOS 5, but [JIRA no longer supports PostgreSQL 8.1](https://confluence.atlassian.com/display/JIRAKB/2012/07/23/Advance+warning+-+end+of+support+for+PostgreSQL+8.2+with+JIRA+5.2) so you would need to use PostgreSQL 8.4 or host the database on another server.

## Cookbooks

* database
* postgresql

Attributes
==========

This cookbook assumes that you'll install JIRA into /opt, but this is configurable.

Other common user-serviceable parts:

* `node['jira']['homedir']` - Atlassian's documentation calls this the "home directory", but this is really where JIRA will store its working files.

If integrating with Crowd, the following attributes can be set:

* `node['jira']['crowd_sso']['sso_appname']` - the "app name" in Crowd
* `node['jira']['crowd_sso']['sso_password']` - the "app password" to authenticate against Crowd with
* `node['jira']['crowd_sso']['crowd_base_url']` - the Crowd base URL

Recipes
=======

## default

Does nothing.

## server

Unpack Atlassian JIRA from the tarball and perform basic configuration allowing you to set it up.

## local_database

Sets up a local PostgreSQL database for JIRA to talk to.

## crowd_sso

Does some basic configuration of JIRA for integration with Atlassian Crowd for single-sign-on/directory integration.

Limitations
===========

* It's obviously impossible to Chef out the entire JIRA install because much of it is interactive. This cookbook deals with getting JIRA onto the system and the database set up, not configuring the actual app itself.
* Various XML files in JIRA need to be edited to make things like SSL termination at a front-end apache work. These can't be managed by Chef: in particular, modifying the "proxyHost", "proxyPort" and "proxyserver" attributes of server.xml
* Single-sign-on configuration with Crowd is not managed by this cookbook either since it also involves editing XML files.

Roadmap
=======

* Support other databases other than PostgreSQL.
* Support databases on machines other than "localhost".
* Support platforms other than RHEL.
* Find a way to manage needed directives in JIRA's XML configs.

License and Author
==================

- Author:: Julian C. Dunn <jdunn@opscode.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
