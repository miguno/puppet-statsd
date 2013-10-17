class statsd::params {

  # Install
  $defaults_file     = '/etc/default/statsd'
  $defaults_template = "${module_name}/statsd-defaults.erb"
  $init_file         = '/etc/init.d/statsd'
  $log_file          = '/var/log/statsd/statsd.log'
  $package_ensure    = 'present'
  $package_name      = 'statsd'
  $package_provider  = 'npm'
  $service_ensure    = 'running'
  $service_manage    = true
  $service_name      = 'statsd'
  $statsd_bin        = "puppet:///modules/${module_name}/statsd-wrapper"
  $statsd_bin_file   = '/usr/local/sbin/statsd'
  # Config
  $backends          = [ './backends/graphite' ]
  $config_file       = '/etc/statsd/localConfig.js'
  $config_variables  = {}
  $flush_interval    = 10000
  $graphite_port     = 2003
  $graphite_server   = 'localhost'
  $listen_address    = '0.0.0.0'
  $listen_port       = 8125
  $node_module_dir   = undef
  $percent_threshold = ['90']

  case $::osfamily {
    'RedHat': {
      $init_content = "puppet:///modules/${module_name}/statsd-init-rhel"
      if ! $node_module_dir {
        $statsjs_file = '/usr/lib/node_modules/statsd/stats.js'
      }
      else {
        $statsjs_file = "${node_module_dir}/statsd/stats.js"
      }
    }
    'Debian': {
      $init_content = "puppet:///modules/${module_name}/statsd-init"
      if ! $node_module_dir {
        case $package_provider {
          'apt': {
            $statsjs_file = '/usr/share/statsd/stats.js'
          }
          'npm': {
            $statsjs_file = '/usr/lib/node_modules/statsd/stats.js'
          }
          default: {
            fail('Unsupported provider')
          }
        }
      }
      else {
        $statsjs_file = "${node_module_dir}/statsd/stats.js"
      }
    }
    default: {
      fail('Unsupported OS Family')
    }
  }

}
