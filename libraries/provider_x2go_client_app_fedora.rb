# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: provider_x2go_client_app_fedora
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
      # A Chef provider for the X2go client packages for Fedora.
      #
      # @author Jonathan Hartman <jonathan.hartman@socrata.com>
      class Fedora < X2goClientApp
        provides :x2go_client_app, platform: 'fedora'

        private

        #
        # Install the X2go client package, no special repository needed.
        #
        # (see Chef::Provider::X2goClientApp#install!)
        #
        def install!
          package(new_resource.source || 'x2goclient')
        end

        #
        # Remove the X2go client package.
        #
        # (see Chef::Provider::X2goClientApp#remove!)
        #
        def remove!
          package('x2goclient') { action :remove }
        end
      end
    end
  end
end
