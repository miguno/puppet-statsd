class statsd(
  $backends          = $statsd::params::backends,
  $config_file       = $statsd::params::config_file,
  $config_variables  = $statsd::params::config_variables,
  $defaults_file     = $statsd::params::defaults_file,
  $defaults_template = $statsd::params::defaults_template,
  $flush_interval    = $statsd::params::flush_interval,
  $graphite_port     = $statsd::params::graphite_port,
  $graphite_server   = $statsd::params::graphite_server,
  $init_file         = $statsd::params::init_file,
  $init_content      = $statsd::params::init_content,
  $listen_address    = $statsd::params::listen_address,
  $listen_port       = $statsd::params::listen_port,
  $log_file          = $statsd::params::log_file,
  $node_module_dir   = $statsd::params::node_module_dir,
  $package_ensure    = $statsd::params::package_ensure,
  $package_name      = $statsd::params::package_name,
  $package_provider  = $statsd::params::package_provider,
  $percent_threshold = $statsd::params::percent_threshold,
  $service_ensure    = $statsd::params::service_ensure,
  $service_manage    = hiera('statsd::service_manage', $statsd::params::service_manage),
  $service_name      = $statsd::params::service_name,
  $statsd_bin        = $statsd::params::statsd_bin,
  $statsd_bin_file   = $statsd::params::statsd_bin_file,
  $statsjs_file      = $statsd::params::statsjs_file,
) inherits statsd::params {

  validate_array($backends)
  validate_absolute_path($config_file)
  validate_hash($config_variables)
  validate_absolute_path($defaults_file)
  validate_string($defaults_template)
  if !is_integer($flush_interval) { fail('The $flush_interval parameter must be an integer number') }
  if !is_integer($graphite_port) { fail('The $graphiteport parameter must be an integer number') }
  validate_string($graphite_server)
  validate_absolute_path($init_file)
  validate_string($init_content)
  validate_string($listen_address)
  if !is_integer($listen_port) { fail('The $listen_port parameter must be an integer number') }
  validate_absolute_path($log_file)
  if $node_module_dir != undef { validate_absolute_path($node_module_dir) }
  validate_string($package_ensure)
  validate_string($package_name)
  validate_string($package_provider)
  validate_array($percent_threshold)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($statsd_bin)
  validate_absolute_path($statsd_bin_file)
  validate_absolute_path($statsjs_file)

  require nodejs

  include '::statsd::install'
  include '::statsd::config'
  include '::statsd::service'

  anchor { 'statsd::begin': }
  anchor { 'statsd::end': }

  Anchor['statsd::begin'] ->
  Class['::statsd::install'] ->
  Class['::statsd::config'] ~>
  Class['::statsd::service'] ->
  Anchor['statsd::end']

}
