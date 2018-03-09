# frozen_string_literal: true

require_relative '../x2go_client_app'

describe 'resources::x2go_client_app::debian' do
  include_context 'resources::x2go_client_app'

  shared_examples_for 'any Debian platform' do
    context 'the :install action' do
      include_context description

      context 'the default properties' do
        include_context description

        it 'configures the X2go APT repo' do
          cr = chef_run
          expect(cr).to add_apt_repository('x2go')
            .with(uri: 'http://packages.x2go.org/debian',
                  distribution: cr.node['lsb']['codename'],
                  components: %w[main],
                  keyserver: 'keys.gnupg.net',
                  key: %w[E1F958385BFE2B6E])
        end

        it 'installs the x2goclient package' do
          expect(chef_run).to install_package('x2goclient')
        end
      end

      context 'a source property' do
        include_context description

        it 'does not configure the X2go APT repo' do
          expect(chef_run).to_not add_apt_repository('x2go')
        end

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

      it 'removes the X2go APT repo' do
        expect(chef_run).to remove_apt_repository('x2go')
      end
    end
  end

  let(:platform) { 'debian' }

  RSpec.configuration.supported_platforms[:debian].each do |ver|
    context ver do
      let(:platform_version) { ver }

      it_behaves_like 'any Debian platform'
    end
  end
end
