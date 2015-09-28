# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: provider_x2go_client
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

class Chef
  class Provider
    # A parent Chef provider for all the X2go client components.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClient < LWRPBase
      use_inline_resources

      provides :x2go_client

      #
      # WhyRun is supported by this provider
      #
      # (see Chef::Provider#whyrun_supported?)
      #
      def whyrun_supported?
        true
      end

      #
      # Install the X2go client app.
      #
      action :create do
        x2go_client_app(new_resource.name) { source new_resource.source }
      end

      #
      # Uninstall the X2go client app.
      #
      action :remove do
        x2go_client_app(new_resource.name) { action :remove }
      end
    end
  end
end
