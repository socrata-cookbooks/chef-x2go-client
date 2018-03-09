# X2go Client Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/x2go-client.svg)][cookbook]
[![OS X Build Status](https://img.shields.io/travis/socrata-cookbooks/x2go-client.svg)][travis]
[![Windows Build Status](https://img.shields.io/appveyor/ci/socrata-cookbooks/x2go-client.svg)][appveyor]
[![Linux Build Status](https://img.shields.io/circleci/project/socrata-cookbooks/x2go-client.svg)][circle]
[![Code Climate](https://img.shields.io/codeclimate/github/socrata-cookbooks/x2go-client.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/socrata-cookbooks/x2go-client.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/x2go-client
[travis]: https://travis-ci.org/socrata-cookbooks/x2go-client
[appveyor]: https://ci.appveyor.com/project/socrata-cookbooks/x2go-client
[circle]: https://circleci.com/gh/socrata-cookbooks/x2go-client
[codeclimate]: https://codeclimate.com/github/socrata-cookbooks/x2go-client
[coveralls]: https://coveralls.io/r/socrata-cookbooks/x2go-client

A Chef cookbook for the X2go remote desktop client.

## Requirements

This cookbook requires Chef 12.6+.

It currently supports Mac OS X, Windows, Ubuntu, and Red Hat/CentoS/Scientific/
etc.

## Usage

Add the default recipe to your run_list or use one or more of the included
resources in a recipe of your own.

## Recipes

***default***

Do a simple attribute-based install of the X2go client.

## Attributes

***default***

    default['x2go_client']['app']['source'] = nil

An optioanl source URL or file path to install the X2go client package from.

## Resources

***x2go_client***

A parent resource for the X2go client components.

Syntax:

    x2go_client 'default' do
      source 'http://example.com/x2go.package
      action :create
    end

Actions:

| Action    | Description               |
|-----------|---------------------------|
| `:create` | Install the X2go client   |
| `:remove` | Uninstall the X2go client |

Attributes:

| Attribute | Default   | Description                         |
|-----------|-----------|-------------------------------------|
| source    | `nil`     | An optional custom package path/URL |
| action    | `:create` | Action(s) to perform                |

***x2go_client_app***

A resource for installation and removal of X2go client app packages.

Syntax:

    x2go_client_app 'default' do
      source 'http://example.com/x2go.package'
      action :install
    end

Actions:

| Action     | Description                       |
|------------|-----------------------------------|
| `:install` | Install the X2go client package   |
| `:remove`  | Uninstall the X2go client package |

Attributes:

| Attribute | Default    | Description                         |
|-----------|------------|-------------------------------------|
| source    | `nil`      | An optional custom package path/URL |
| action    | `:install` | Action(s) to perform                |

## Maintainers

- Author: Jonathan Hartman <jonathan.hartman@socrata.com>
