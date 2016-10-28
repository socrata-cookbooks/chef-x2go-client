# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::debian::8_2' do
  include_context 'resources::x2go_client'

  let(:platform) { 'debian' }
  let(:platform_version) { '8.2' }

  it_behaves_like 'any platform'
end
