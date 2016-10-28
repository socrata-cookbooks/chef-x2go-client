# encoding: utf-8
# frozen_string_literal: true

require_relative '../../x2go_client'

describe 'resources::x2go_client::fedora::23' do
  include_context 'resources::x2go_client'

  let(:platform) { 'fedora' }
  let(:platform_version) { '23' }

  it_behaves_like 'any platform'
end
