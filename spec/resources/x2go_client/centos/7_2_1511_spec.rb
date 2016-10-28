# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::centos::7_2_1511' do
  include_context 'resources::x2go_client'

  let(:platform) { 'centos' }
  let(:platform_version) { '7.2.1511' }

  it_behaves_like 'any platform'
end
