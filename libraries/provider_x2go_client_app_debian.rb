# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: provider_x2go_client_app_debian
#
# Copyright 2015-2016, Socrata, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/dsl/include_recipe'
require 'chef/provider/lwrp_base'
require_relative 'provider_x2go_client_app'

class Chef
  class Provider
    class X2goClientApp < LWRPBase
      # A Chef provider for the X2go client packages for Debian.
      #
      # @author Jonathan Hartman <jonathan.hartman@socrata.com>
      class Debian < X2goClientApp
        include Chef::DSL::IncludeRecipe

        provides :x2go_client_app, platform: 'debian'

        private

        #
        # Set up the X2go APT repo and install the client packages.
        #
        # (see Chef::Provider::X2goClientApp#install!)
        #
        def install!
          include_recipe 'apt'
          repository(:add) unless new_resource.source
          package(new_resource.source || 'x2goclient')
        end

        #
        # Uninstall the X2go client package and remove the APT repo.
        #
        # (see Chef::Provider::X2goClientApp#remove!)
        #
        def remove!
          package('x2goclient') { action :remove }
          repository(:remove)
        end

        #
        # Perform an action against the apt_repository resource for X2go.
        #
        # @param do_action [Symbol] the action to perform
        #
        def repository(do_action)
          apt_repository 'x2go' do
            uri 'http://packages.x2go.org/debian'
            distribution node['lsb']['codename']
            components %w(main)
            keyserver 'keys.gnupg.net'
            key 'E1F958385BFE2B6E'
            action do_action
          end
        end
      end
    end
  end
end
