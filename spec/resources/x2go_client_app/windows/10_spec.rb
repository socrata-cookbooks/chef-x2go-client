# encoding: utf-8
# frozen_string_literal: true

require_relative '../windows'

describe 'resources::x2go_client_app::windows::10' do
  include_context 'resources::x2go_client_app::windows'

  let(:platform) { 'windows' }
  let(:platform_version) { '10' }

  it_behaves_like 'any Windows platform'
end
