require_relative '../../../spec_helper'

describe 'resource_x2go_client_app::redhat::7_1' do
  let(:source) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'x2go_client_app', platform: 'redhat', version: '7.1'
    ) do |node|
      node.set['x2go_client']['app']['source'] = source unless source.nil?
    end
  end
  let(:converge) { runner.converge("resource_x2go_client_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }

    shared_examples_for 'any attribute set' do
      it 'configures EPEL' do
        expect(chef_run).to include_recipe('yum-epel')
      end
    end

    context 'the default attributes' do
      let(:source) { nil }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'

      it 'installs the x2goclient package' do
        expect(chef_run).to install_package('x2goclient')
      end
    end

    context 'a source attribute' do
      let(:source) { 'https://example.com/x2go.pkg' }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'

      it 'installs the source package' do
        expect(chef_run).to install_package(source)
      end
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'removes the x2goclient package' do
      expect(chef_run).to remove_package('x2goclient')
    end
  end
end
