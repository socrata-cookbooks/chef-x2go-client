# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: provider_x2go_client_app_windows
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

require 'chef/provider/lwrp_base'
require_relative 'provider_x2go_client_app'

class Chef
  class Provider
    class X2goClientApp < LWRPBase
      # A Chef provider for the X2go client package for Windows.
      #
      # @author Jonathan Hartman <jonathan.hartman@socrata.com>
      class Windows < X2goClientApp
        PATH ||= ::File.expand_path('/Program Files (x86)/x2goclient')
        URL ||= 'http://code.x2go.org/releases/' \
                'X2GoClient_latest_mswin32-setup.exe'

        provides :x2go_client_app, platform_family: 'windows'

        private

        #
        # Use a windows_package resource to download and install the X2go
        # client.
        #
        # (see Chef::Provider::X2goClientApp#install!)
        #
        def install!
          x2go_client_package(:install)
        end

        #
        # Use a windows_package resource to remove the X2go package.
        #
        # (see Chef::Provider::X2goClientApp#remove!)
        #
        def remove!
          x2go_client_package(:remove)
        end

        #
        # Return a windows_package resource for the X2go client, set to perform
        # a specified action.
        #
        # @param do_action [Symbol, Array<Symbol>] the action(s) to perform
        #
        # @return [Chef::Resource::WindowsPackage] an X2go windows_package
        #
        def x2go_client_package(do_action)
          s = new_resource.source || URL
          windows_package 'X2Go Client for Windows' do
            source s
            installer_type :nsis
            action do_action
          end
        end
      end
    end
  end
end
