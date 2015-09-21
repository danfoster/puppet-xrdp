# == Class: xrdp
#
# Full description of class xrdp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'xrdp':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class xrdp (
  $manage_repo      = $::xrdp::params::manage_repo,
  $manage_firewall  = $::xrdp::params::manage_firewall,
  $repo_release_rpm = $::xrdp::params::repo_release_rpm
) inherits ::xrdp::params {

  if ($manage_repo) {
    case $::osfamily {
      'RedHat': {
        package { 'nux-dextop-release':
          provider => 'rpm',
          source   => $repo_release_rpm
        }
      }
      default: {
        alert{ "${::osfamily} is not supported.":
        }
      }
    }
  }

  package { 'xrdp':
    ensure  => present,
    require => Package['nux-dextop-release']
  }

  service { 'xrdp':
    ensure  => running,
    require => Package['xrdp']
  }

  service { 'xrdp-sesman':
    ensure  => running,
    require => Package['xrdp'],
  }

  if ($manage_firewall) {
    firewall { '050 Accept RDP':
      proto  => 'tcp',
      port   => 3389,
      action => 'accept'
    }
  }

}
