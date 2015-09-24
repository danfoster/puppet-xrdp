# == Class: xrdp
#
# This module deploys a RDP Server using xrdp, xrdp-sesman and Xvnc.
#
# === Parameters
#
# [*manage_repo*]
#   Add a repo that provides the xrdp package by installing the release rpm as
#   specified in $repo_release_rpm. Default: true
#
# [*manage_firewall*]
#   Open firewall holes. Requires the puppetlabs/firewall module. Default: true
#
# [*repo_release_rpm*]
#   The release RPM to use if manage_repo is true. 
#
# === Examples
#
#  class { 'xrdp':
#  }
#
# === Authors
#
# Dan Foster <dan@zem.org.uk>
#
# === Copyright
#
# Copyright 2015 Dan Foster, unless otherwise noted.
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
          source   => $repo_release_rpm,
          before   => Package['xrdp']
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

  # UK keyboard mapping
  file { '/etc/xrdp/km-0809.ini':
    ensure => present,
    owner  => root,
    group  => root,
    source => 'puppet:///modules/xrdp/km-0809.ini'
  }
}
