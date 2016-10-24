# encoding: utf-8
# frozen_string_literal: true

require_relative '../fedora'

describe 'resources::x2go_client_app::fedora::23' do
  include_context 'resources::x2go_client_app::fedora'

  let(:platform) { 'fedora' }
  let(:platform_version) { '23' }

  it_behaves_like 'any Fedora platform'
end
