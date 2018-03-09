# frozen_string_literal: true

#
# Cookbook Name:: x2go-client
# Library:: resource/x2go_client_app_mac_os_x
#
# Copyright 2015-2018, Socrata, Inc.
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
require_relative 'x2go_client_app'

class Chef
  class Resource
    # A MacOS implementation of the x2go_client_app resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientAppMacOsX < X2goClientApp
      PATH ||= '/Applications/x2goclient.app'.freeze

      include Chef::DSL::IncludeRecipe

      provides :x2go_client_app, platform_family: 'mac_os_x'

      #
      # Use a dmg_package resource to download and install the X2go client.
      #
      action :install do
        include_recipe 'xquartz'
        s = new_resource.source || remote_path
        dmg_package 'x2goclient' do
          source s
        end
      end

      #
      # Delete the X2go client application directory.
      #
      action :remove do
        directory PATH do
          recursive true
          action :delete
        end
      end

      #
      # Return the remote URL of the .dmg file to download. X2go publishes
      # different packages for different versions of MacOS.
      #
      # @return [String] a .dmg package URL for the current platform
      #
      def remote_path
        pv = node['platform_version'].split('.')[1].to_i

        file_pv = if pv >= 12
                    12
                  elsif pv >= 10
                    10
                  else
                    9
                  end

        'https://code.x2go.org/releases/' \
          "X2GoClient_latest_macosx_10_#{file_pv}.dmg"
      end
    end
  end
end
