require_relative '../../../spec_helper'

describe 'resource_x2go_client_app::mac_os_x::10_8_2' do
  let(:source) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'x2go_client_app', platform: 'mac_os_x', version: '10.8.2'
    ) do |node|
      node.set['x2go_client']['app']['source'] = source unless source.nil?
    end
  end
  let(:converge) { runner.converge("resource_x2go_client_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }

    shared_examples_for 'any attribute set' do
      it 'installs xquartz' do
        expect(chef_run).to include_recipe('xquartz')
      end
    end

    context 'the default attributes' do
      let(:source) { nil }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'

      it 'installs from the default download URL' do
        expect(chef_run).to install_dmg_package('x2goclient')
          .with(source: 'http://code.x2go.org/releases/X2GoClient_latest_' \
                        'macosx.dmg')
      end
    end

    context 'a source attribute' do
      let(:source) { 'https://example.com/x2go.pkg' }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'

      it 'installs from the source URL' do
        expect(chef_run).to install_dmg_package('x2goclient')
          .with(source: source)
      end
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'deletes the main application directory' do
      expect(chef_run).to delete_directory('/Applications/x2goclient.app')
        .with(recursive: true)
    end
  end
end
