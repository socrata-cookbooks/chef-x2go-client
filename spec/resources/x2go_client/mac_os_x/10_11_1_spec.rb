# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::mac_os_x::10_11_1' do
  include_context 'resources::x2go_client'

  let(:platform) { 'mac_os_x' }
  let(:platform_version) { '10.11.1' }

  it_behaves_like 'any platform'
end
