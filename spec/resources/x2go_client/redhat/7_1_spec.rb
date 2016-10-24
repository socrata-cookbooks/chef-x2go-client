# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::redhat::7_1' do
  include_context 'resources::x2go_client'

  let(:platform) { 'redhat' }
  let(:platform_version) { '7.1' }

  it_behaves_like 'any platform'
end
