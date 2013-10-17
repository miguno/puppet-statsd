# puppet-statsd

Manage [statsd](https://github.com/etsy/statsd/) with Puppet.


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
```

See [params.pp](manifests/params.pp) for default settings such as stats'd default UDP listen port.


# Contributors

  * Thanks to Ben Hughes (ben@puppetlabs.com) for initial implementation
