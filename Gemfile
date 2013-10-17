source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['~> 3.0.1']
end

group :rake do
  gem 'puppet',       puppetversion
  gem 'rspec-puppet', '>=0.1.3'
  gem 'rake',         '>=0.9.2.2'
  gem 'puppet-lint',  '>=0.1.12'
  gem 'puppetlabs_spec_helper'
  # See https://github.com/maestrodev/puppet-blacksmith
  gem 'puppet-blacksmith', '>=1.0.1'
  gem 'librarian-puppet-maestrodev', '>=0.9.7.4'
end
