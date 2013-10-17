class statsd::service inherits statsd {

  if ($service_manage) {

    if $service_ensure == 'running' {
      $ensure_real = 'running'
      $enable_real = true
    }
    else {
      $ensure_real = 'stopped'
      $enable_real = false
    }

    service { 'statsd':
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
