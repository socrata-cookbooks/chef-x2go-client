require_relative '../../../spec_helper'

describe 'resource_x2go_client_app::windows::10' do
  let(:source) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'x2go_client_app', platform: 'windows', version: '10'
    ) do |node|
      node.default['x2go_client']['app']['source'] = source unless source.nil?
    end
  end
  let(:converge) { runner.converge("resource_x2go_client_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }

    context 'the default attributes' do
      let(:source) { nil }
      cached(:chef_run) { converge }

      it 'installs from the default download URL' do
        expect(chef_run).to install_windows_package('X2Go Client for Windows')
          .with(source: 'http://code.x2go.org/releases/X2GoClient_latest_' \
                        'mswin32-setup.exe',
                installer_type: :nsis)
      end
    end

    context 'a source attribute' do
      let(:source) { 'https://example.com/x2go.pkg' }
      cached(:chef_run) { converge }

      it 'installs from the source URL' do
        expect(chef_run).to install_windows_package('X2Go Client for Windows')
          .with(source: source, installer_type: :nsis)
      end
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'removes the X2Go Client package' do
      expect(chef_run).to remove_windows_package('X2Go Client for Windows')
        .with(source: 'http://code.x2go.org/releases/X2GoClient_latest_' \
                      'mswin32-setup.exe',
              installer_type: :nsis)
    end
  end
end
