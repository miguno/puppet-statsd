class statsd(
  $backends          = $statsd::params::backends,
  $config            = $statsd::params::config,
  $ensure            = $statsd::params::ensure,
  $flush_interval    = $statsd::params::flush_interval,
  $graphite_port     = $statsd::params::graphite_port,
  $graphite_server   = $statsd::params::graphite_server,
  $init_script       = $statsd::params::init_script,
  $listen_address    = $statsd::params::listen_address,
  $listen_port       = $statsd::params::listen_port,
  $percent_threshold = $statsd::params::percent_threshold,
  $provider          = $statsd::params::provider,
  $statsjs           = $statsd::params::statsjs,
) inherits statsd::params {

  validate_array($backends)
  validate_hash($config)
  validate_string($ensure)
  if !is_integer($flush_interval) { fail('The $flush_interval parameter must be an integer number') }
  if !is_integer($graphite_port) { fail('The $graphiteport parameter must be an integer number') }
  validate_string($graphite_server)
  validate_string($init_script)
  validate_string($listen_address)
  if !is_integer($listen_port) { fail('The $listen_port parameter must be an integer number') }
  validate_array($percent_threshold)
  validate_string($provider)
  validate_absolute_path($statsjs)

  require nodejs

  package { 'statsd':
    ensure   => $ensure,
    provider => $provider,
    notify  => Service['statsd'],
  }

  $config_file  = '/etc/statsd/localConfig.js'
  $log_file     = '/var/log/statsd/statsd.log'

  file { '/etc/statsd':
    ensure => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  } ->
  file { $config_file:
    content => template('statsd/localConfig.js.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['statsd'],
  }
  file { '/etc/init.d/statsd':
    source  => $init_script,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }
  file {  '/etc/default/statsd':
    content => template('statsd/statsd-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }
  file { '/var/log/statsd':
    ensure => directory,
    owner  => 'nobody',
    group  => 'root',
    mode   => '0770',
  }
  file { '/usr/local/sbin/statsd':
    source  => 'puppet:///modules/statsd/statsd-wrapper',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['statsd'],
  }

  service { 'statsd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    pattern   => 'node .*stats.js',
    require   => File['/var/log/statsd'],
  }
}
