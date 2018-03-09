# frozen_string_literal: true

require_relative '../resources'

describe 'resources::x2go_client' do
  include_context 'resources'

  let(:resource) { 'x2go_client' }
  %i[source].each { |p| let(p) { nil } }
  let(:properties) { { source: source } }
  let(:name) { 'default' }

  shared_examples_for 'any platform' do
    context 'the default action (:create)' do
      shared_examples_for 'any property set' do
        it 'installs the x2go_client_app' do
          expect(chef_run).to install_x2go_client_app('default')
            .with(source: source)
        end
      end

      context 'the default properties' do
        it_behaves_like 'any property set'
      end

      context 'a source property' do
        let(:source) { 'https://example.com/x2go.pkg' }

        it_behaves_like 'any property set'
      end
    end

    context 'the :remove action' do
      let(:action) { :remove }

      it 'removes the x2go_client_app' do
        expect(chef_run).to remove_x2go_client_app('default')
      end
    end
  end

  RSpec.configuration.supported_platforms.each do |os, versions|
    context os.to_s.capitalize do
      let(:platform) { os.to_s }

      versions.each do |ver|
        context ver do
          let(:platform_version) { ver }

          it_behaves_like 'any platform'
        end
      end
    end
  end
end
