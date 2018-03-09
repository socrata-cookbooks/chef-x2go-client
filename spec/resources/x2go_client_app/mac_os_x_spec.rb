# frozen_string_literal: true

require_relative '../x2go_client_app'

describe 'resources::x2go_client_app::mac_os_x' do
  include_context 'resources::x2go_client_app'

  let(:package_filename) { nil }

  shared_examples_for 'any MacOS platform' do
    context 'the :install action' do
      include_context description

      shared_examples_for 'any property set' do
        it 'installs xquartz' do
          expect(chef_run).to include_recipe('xquartz')
        end
      end

      context 'the default properties' do
        include_context description

        it_behaves_like 'any property set'

        it 'installs from the default download URL' do
          pv = platform_version.split('.')[1].to_i
          file_pv = if pv >= 12
                      12
                    elsif pv >= 10
                      10
                    end
          src =  'https://code.x2go.org/releases/' \
                 "X2GoClient_latest_macosx_10_#{file_pv}.dmg"

          expect(chef_run).to install_dmg_package('x2goclient')
            .with(source: src)
        end
      end

      context 'a source property' do
        include_context description

        it_behaves_like 'any property set'

        it 'installs from the source URL' do
          expect(chef_run).to install_dmg_package('x2goclient')
            .with(source: source)
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'deletes the main application directory' do
        expect(chef_run).to delete_directory('/Applications/x2goclient.app')
          .with(recursive: true)
      end
    end
  end

  let(:platform) { 'mac_os_x' }

  RSpec.configuration.supported_platforms[:mac_os_x].each do |ver|
    context ver do
      let(:platform_version) { ver }

      it_behaves_like 'any MacOS platform'
    end
  end
end
