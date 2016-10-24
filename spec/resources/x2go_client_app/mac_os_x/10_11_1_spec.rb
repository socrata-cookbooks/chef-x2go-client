# encoding: utf-8
# frozen_string_literal: true

require_relative '../mac_os_x'

describe 'resources::x2go_client_app::mac_os_x::10_11_1' do
  include_context 'resources::x2go_client_app::mac_os_x'

  let(:platform) { 'mac_os_x' }
  let(:platform_version) { '10.11.1' }

  let(:package_filename) { 'X2GoClient_latest_macosx_10_9.dmg' }

  it_behaves_like 'any MacOS platform'
end
