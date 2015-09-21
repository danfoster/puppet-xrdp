# == Class xrdp::params
#
# This class is meant to be called from xrdp.
# It sets variables according to platform.
#
class xrdp::params {
  $manage_repo = true
  $manage_firewall = true
  $repo_release_rpm = 'http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm'
}
