class statsd::config inherits statsd {

  $config_directory = dirname($config_file)
  file { $config_directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
  } ->
  file { 'statsd-local.config':
    path    => $config_file,
    content => template("${module_name}/localConfig.js.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['statsd'],
  }

}
