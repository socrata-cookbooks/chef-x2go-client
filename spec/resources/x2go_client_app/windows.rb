# encoding: utf-8
# frozen_string_literal: true

require_relative '../x2go_client_app'

shared_context 'resources::x2go_client_app::windows' do
  include_context 'resources::x2go_client_app'

  shared_context 'any Windows platform' do
    context 'the default action (:install)' do
      include_context description

      context 'the default properties' do
        include_context description

        it 'installs from the default download URL' do
          expect(chef_run).to install_windows_package('X2Go Client for Windows')
            .with(source: 'http://code.x2go.org/releases/X2GoClient_latest_' \
                          'mswin32-setup.exe',
                  installer_type: :nsis)
        end
      end

      context 'a source property' do
        include_context description

        it 'installs from the source URL' do
          expect(chef_run).to install_windows_package('X2Go Client for Windows')
            .with(source: source, installer_type: :nsis)
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes the X2Go Client package' do
        expect(chef_run).to remove_windows_package('X2Go Client for Windows')
          .with(source: 'http://code.x2go.org/releases/X2GoClient_latest_' \
                        'mswin32-setup.exe',
                installer_type: :nsis)
      end
    end
  end
end
