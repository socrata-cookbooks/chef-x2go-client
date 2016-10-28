# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::ubuntu::14_04' do
  include_context 'resources::x2go_client'

  let(:platform) { 'ubuntu' }
  let(:platform_version) { '14.04' }

  it_behaves_like 'any platform'
end
