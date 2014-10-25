# osqa-docker

This project provides the resources necessary to create a Docker container for the [Open Source Q&amp;A system](http://www.osqa.net).

## Objective
Create a Docker image for publication to [Docker Hub](https://hub.docker.com).

## Usage Instructions
On your Docker Environment:

1. Clone the GitHub Repo
2. cd osqa-docker
3. docker build -t vinomaster/osqa-docker .
4. docker run -d -P -t vinomaster/osqa-docker

## Status
This project attempts to containerize teh OSQA solution using [Ubuntu+Apache+MySQL](http://wiki.osqa.net/display/docs/Ubuntu+with+Apache+and+MySQL).
**NOTE**: This project is *Incomplete*. It is a work-in-progress, as serveral build errors still exist.

1. Unable to build using django trunk.
2. Unable to build with django==1.6
3. Unable to build using source code from [GitHub](https://github.com/dzone/OSQA)
4. Unable to build using source code from [SVN](http://svn.osqa.net/browse/OSQA/osqa/trunk)
