class statsd::params {
  $backends          = [ './backends/graphite' ]
  $config            = { }
  $ensure            = 'present'
  $flush_interval    = 10000
  $graphite_port     = 2003
  $graphite_server   = 'localhost'
  $listen_address    = '0.0.0.0'
  $listen_port       = 8125
  $percent_threshold = ['90']
  $provider          = 'npm'
  $node_module_dir   = ''

  case $::osfamily {
    'RedHat': {
      $init_script = 'puppet:///modules/statsd/statsd-init-rhel'
      if ! $node_module_dir {
        $statsjs = '/usr/lib/node_modules/statsd/stats.js'
      }
      else {
        $statsjs = "${node_module_dir}/statsd/stats.js"
      }
    }
    'Debian': {
      $init_script = 'puppet:///modules/statsd/statsd-init'
      if ! $node_module_dir {
        case $provider {
          'apt': {
            $statsjs = '/usr/share/statsd/stats.js'
          }
          'npm': {
            $statsjs = '/usr/lib/node_modules/statsd/stats.js'
          }
          default: {
            fail('Unsupported provider')
          }
        }
      }
      else {
        $statsjs = "${node_module_dir}/statsd/stats.js"
      }
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
