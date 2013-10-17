class statsd::install inherits statsd {

  package { 'statsd':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
    notify   => Class['statsd::service'],
  }

  file { 'statsd-init-script':
    path   => $init_file,
    source => $init_content,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    notify => Class['statsd::service'],
  }

  file {  'statsd-defaults.config':
    path    => $defaults_file,
    content => template($defaults_template),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Class['statsd::service'],
  }

  $log_directory = dirname($log_file)
  file { $log_directory:
    ensure  => directory,
    owner   => 'nobody',
    group   => 'root',
    mode    => '0770',
    recurse => true,
  }

  file { 'statsd-wrapper':
    path   => $statsd_bin_file,
    source => $statsd_bin,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    notify => Class['statsd::service'],
  }

}
