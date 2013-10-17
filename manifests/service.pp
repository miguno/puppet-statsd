class statsd::service inherits statsd {

  validate_re($service_ensure, '^(running|stopped)$', 'The $service_ensure value must be either "running" or "stopped"')
  validate_bool($service_manage)

  if ($service_manage) {
    if $service_ensure == 'running' {
      $ensure_real = 'running'
      $enable_real = true
    } else {
      $ensure_real = 'stopped'
      $enable_real = false
    }

    service { 'statsd-daemon':
      name       => $service_name,
      ensure     => $ensure_real,
      enable     => $enable_real,
      hasstatus  => true,
      hasrestart => true,
      pattern    => 'node .*stats.js',
      require    => Class['statsd::install'],
    }

  }

}
