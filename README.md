# puppet-module-golang

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/golang.svg)](https://forge.puppetlabs.com/treydock/golang)
[![Build Status](https://travis-ci.org/treydock/puppet-module-golang.png)](https://travis-ci.org/treydock/puppet-module-golang)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module installs go binary for Linux systems.

## Usage

### golang

Install Go

    class { 'golang': }

Install specific version of Go

    class { 'golang':
      version => '1.14',
    }

## Reference

[http://treydock.github.io/puppet-module-golang/](http://treydock.github.io/puppet-module-golang/)

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake release_checks

If you have Docker installed you can run system tests

    bundle exec rake beaker
