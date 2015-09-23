Description
===========

Installs [Atlassian JIRA](https://www.atlassian.com/software/jira/overview), a popular project-management and ticketing system for software project teams.

Requirements
============

## Platforms

* CentOS 6/RHEL6
* Chef 12

Attributes
==========

This cookbook assumes that you'll install JIRA into /opt, but this is configurable.

Recipes
=======

## default

Runs the installation and configuration.

## install

Configure and run the Atlassian JIRA installer (recommended way of installing JIRA).

## configure

Configure JIRA to use the internal HSQL database with no additional tuning.

License and Author
==================

- Author:: Julian C. Dunn <jdunn@chef.io>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
