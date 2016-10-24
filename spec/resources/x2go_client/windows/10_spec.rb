# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::windows::10' do
  include_context 'resources::x2go_client'

  let(:platform) { 'windows' }
  let(:platform_version) { '10' }

  it_behaves_like 'any platform'
end
