# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: provider_x2go_client_app_mac_os_x
#
# Copyright 2015 Socrata, Inc.
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
      # A Chef provider for the X2go client package for Mac OS X.
      #
      # @author Jonathan Hartman <jonathan.hartman@socrata.com>
      class MacOsX < X2goClientApp
        PATH ||= '/Applications/x2goclient.app'

        include Chef::DSL::IncludeRecipe

        provides :x2go_client_app, platform_family: 'mac_os_x'

        private

        #
        # Use a dmg_package resource to download and install the X2go client.
        #
        # (see Chef::Provider::X2goClientApp#install!)
        #
        def install!
          s = new_resource.source || remote_path
          dmg_package 'x2goclient' do
            source s
          end
        end

        #
        # Delete the X2go client application directory.
        #
        # (see Chef::Provider::X2goClientApp#remove!)
        #
        def remove!
          directory PATH do
            recursive true
            action :delete
          end
        end

        #
        # Return the remote URL of the .dmg file to download. X2go publishes
        # two packages for OS X: one for >= 10.9 and one for < 10.9.
        #
        # @return [String] a .dmg package URL for the current platform
        #
        def remote_path
          pv = node['platform_version']
          url = 'http://code.x2go.org/releases/'
          url << if Gem::Version.new(pv) >= Gem::Version.new('10.9')
                   'X2GoClient_latest_macosx_10_9.dmg'
                 else
                   'X2GoClient_latest_macosx.dmg'
                 end
        end
      end
    end
  end
end
