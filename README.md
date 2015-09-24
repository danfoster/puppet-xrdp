# xrdp

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Beginning with xrdp](#beginning-with-xrdp)
4. [Usage - Configuration options and additional functionality](#usage)
6. [Development - Guide for contributing to the module](#development)

## Overview


Module to run an RDP server using xrdp.

## Module Description


This module deploys a RDP Server using xrdp, xrdp-sesman and Xvnc.

## Beginning with xrdp

Simple deployments can be as easy as including the xrdp class:

```
class {'xrdp':
}
```


## Usage

Deployments can be as easy as including the xrdp class:

```
class {'xrdp':
}
```

Or the following parameters can be used

### `manage_repo`

Add a repo that provides the xrdp package by installing the release rpm as pecified in `$repo_release_rpm`. Default: `true`

### `manage_firewall`

Open firewall holes. Requires the `puppetlabs/firewall` module. Default: `true`

### `repo_release_rpm`

The release RPM to use if manage_repo is true.


## Development

Pull requests are gratefully received.
