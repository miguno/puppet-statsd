# puppet-statsd [![Build Status](https://travis-ci.org/miguno/puppet-statsd.png?branch=master)](https://travis-ci.org/miguno/puppet-statsd)

A Puppet module for managing the installation and configuration of [statsd](https://github.com/etsy/statsd/).

---

Table of Contents

* <a href="#usage">Usage and configuration</a>
* <a href="#requirements">Requirements</a>
* <a href="#development-enviroment">Setting up a local development environment</a>
    * <a href="#tests">Running tests</a>
    * <a href="#lint">Running lint</a>
* <a href="#credits">Credits</a>

---

<a name="usage"></a>

# Usage and configuration

In Puppet manifests:

```puppet
class { 'statsd':
  graphite_server   => 'my.graphite.server',
  flush_interval    => 1000, # flush metric data every second to Graphite
  listen_address    => '10.20.1.2',
  listen_port       => 2158,
  percent_threshold => [75, 90, 99],
}
```

In Hiera:

```yaml
statsd::graphite_server: 'my.graphite.server'
statsd::flush_interval: 1000 # flush metric data every second to Graphite
statsd::listen_address: '10.20.1.2'
statsd::listen_port: 2158
statsd::percent_threshold:
  - 75
  - 90
  - 99
statsd::config_variables:
  'graphite':
    'legacyNamespace': false
```

The above settings will result in the following `localConfig.js`:

```
{
  backends: [ "./backends/graphite" ]
, graphitePort: "2003"
, graphiteHost: "my.graphite.server"
, address: "10.20.1.2"
, port: "2158"
, flushInterval: "1000"
, percentThreshold: [75, 90, 99]
, graphite: {
    legacyNamespace: false
  }
}
```

* See [params.pp](manifests/params.pp) for default settings such as the default UDP port of statsd.
* You can use the `$config_variables` class parameter (which is a hash) to add further statsd settings
  dynamically to localConfig.js.  See [localConfig.js.erb](templates/localConfig.js.erb) for implementation
  details.


<a name="requirements"></a>

# Requirements

_Tested on RHEL/CentOS 6._

* Puppet 3.0+
* Ruby 1.9 (preferred) or 1.8


<a name="develoment-environment"></a>

# Setting up a local development environment

After cloning this git repository you only need to run:

    $ ./bootstrap.sh


<a name="tests"></a>

## Running tests

    $ rake spec


<a name="lint"></a>

## Running lint

    $ rake lint


<a name="credits"></a>

# Credits

This module is based on -- and a fork of -- the great work done by
[puppetlabs-operations](https://github.com/puppetlabs-operations/puppet-statsd).
