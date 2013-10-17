class statsd::service inherits statsd {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('The $service_ensure value must be either "running" or "stopped"')
  }

  if $service_manage == true {

    if $service_ensure == 'running' {
      $ensure_real = 'running'
      $enable_real = true
    }
    else {
      $ensure_real = 'stopped'
      $enable_real = false
    }

    service { 'statsd':
      ensure     => $ensure_real,
      enable     => $enable_real,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
      pattern    => 'node .*stats.js',
      require    => Class['statsd::install'],
    }

  }

}
