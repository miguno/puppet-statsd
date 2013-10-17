#!/usr/bin/env bash
#
# File: bootstrap
# Description: This script bootstraps a local (Ruby) development environment for the puppet-statsd module.

MYSELF=`basename $0`
MY_DIR=`echo $(cd $(dirname $0); pwd)`
. $MY_DIR/sh/common.sh

puts "+---------------+"
puts "| BOOTSTRAPPING |"
puts "+---------------+"

###
### Ruby
###
puts "Preparing Ruby environment..."
curl -L https://raw.github.com/miguno/ruby-bootstrap/master/ruby-bootstrap.sh | bash -s
