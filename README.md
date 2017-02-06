[![CircleCI](https://circleci.com/gh/bitnami/bitnami-docker-laravel/tree/che.svg?style=shield)](https://circleci.com/gh/bitnami/bitnami-docker-laravel/tree/che)
[![Docker Hub Automated Build](http://container.checkforupdates.com/badges/bitnami/che-laravel)](https://hub.docker.com/r/bitnami/che-laravel/)

# Eclipse Che Developer Workspace
You can use this Development environment to create an Eclipse Che on-demand workspace with a sample project ready to start developing. Click the link below to automatically create and launch a Laravel environment workspace on Codenvy:

[![Contribute](http://beta.codenvy.com/factory/resources/codenvy-contribute.svg)](https://beta.codenvy.com/f/?url=https%3A%2F%2Fgithub.com%2Famrecio%2Fbitnami-docker-laravel%2Ftree%2Fdependencies)

## Why Eclipse Che?
We think developers are adopting containers for development because they offer many of the same advantages as developing in VMs, but with lower overhead in terms of developer effort and development machine resources. With Eclipse Che, each workspace is a Docker container, protecting it from dependency conflicts. Che workspaces can be created for a brand new project, built to match a production deployment, or automatically created as part of the continuous integration pipeline. Che’s workspace configuration files also allow you to encompasses project sources, build/debug runtimes and execute commands.

## How does it works?
It's very simple, you just need a environment container's Docker Image and create a JSON configuration file defining the content and the structure of the workspace.

We already provide both the workspace's configuration file and the Swift development container. You can use the previous link to automatically create an on-demand workspace in Codenvy or create it manually on your own Eclipse Che instance. You can obtain an [Eclipse Che Virtual Machine](https://bitnami.com/stack/eclipse-che) or [launch it in the Cloud](https://bitnami.com/stack/eclipse-che/cloud).

You can find more information about Eclipse Che workspaces at the [Eclipse Che Official Documentation](https://eclipse-che.readme.io/docs/introduction).
