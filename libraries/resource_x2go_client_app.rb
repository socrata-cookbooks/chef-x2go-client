# Encoding: UTF-8
#
# Cookbook Name:: x2go-client
# Library:: resource_x2go_client_app
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

require 'chef/resource/lwrp_base'
require_relative 'provider_x2go_client_app'

class Chef
  class Resource
    # A Chef resource for the X2go client app.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientApp < LWRPBase
      self.resource_name = :x2go_client_app
      actions :install, :remove
      default_action :install

      #
      # Attribute to allow an override of the default package source path/URL.
      #
      attribute :source, kind_of: String, default: nil
    end
  end
end
