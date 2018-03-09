# frozen_string_literal: true

require_relative '../x2go_client_app'

describe 'resources::x2go_client_app::fedora' do
  include_context 'resources::x2go_client_app'

  shared_examples_for 'any Fedora platform' do
    context 'the :install action' do
      include_context description

      context 'the default properties' do
        include_context description

        it 'installs the x2goclient package' do
          expect(chef_run).to install_package('x2goclient')
        end
      end

      context 'a source property' do
        include_context description

        it 'installs the source package' do
          expect(chef_run).to install_package(source)
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes the x2goclient package' do
        expect(chef_run).to remove_package('x2goclient')
      end
    end
  end

  let(:platform) { 'fedora' }

  RSpec.configuration.supported_platforms[:fedora].each do |ver|
    context ver do
      let(:platform_version) { ver }

      it_behaves_like 'any Fedora platform'
    end
  end
end
