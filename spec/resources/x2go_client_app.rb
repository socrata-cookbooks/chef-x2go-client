# frozen_string_literal: true

require_relative '../resources'

shared_context 'resources::x2go_client_app' do
  include_context 'resources'

  let(:resource) { 'x2go_client_app' }
  %i[source].each { |p| let(p) { nil } }
  let(:properties) { { source: source } }
  let(:name) { 'default' }

  shared_context 'the :install action' do
  end

  shared_context 'the :remove action' do
    let(:action) { :remove }
  end

  shared_context 'the default properties' do
  end

  shared_context 'a source property' do
    let(:source) { 'https://example.com/x2go.pkg' }
  end
end
