# puppet-module-golang

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/golang.svg)](https://forge.puppetlabs.com/treydock/golang)
[![CI Status](https://github.com/treydock/puppet-module-golang/workflows/CI/badge.svg?branch=master)](https://github.com/treydock/puppet-module-golang/actions?query=workflow%3ACI)

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
      version => '1.24.12',
    }

## Reference

[http://treydock.github.io/puppet-module-golang/](http://treydock.github.io/puppet-module-golang/)
