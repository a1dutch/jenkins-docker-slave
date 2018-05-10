#!/bin/bash

set -ex

# start the docker daemon
wrapdocker &

# run the slave
jenkins-slave
