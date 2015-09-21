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
  $manage_repo = true,
  $repo_release_rpm = 'http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm'
) {

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
    require => Package['nux-dextop-release']
  }

}
