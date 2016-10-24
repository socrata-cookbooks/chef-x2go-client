require_relative '../../../spec_helper'

describe 'resource_x2go_client::ubuntu::14_04' do
  let(:source) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'x2go_client', platform: 'ubuntu', version: '14.04'
    ) do |node|
      node.default['x2go_client']['app']['source'] = source unless source.nil?
    end
  end
  let(:converge) { runner.converge("resource_x2go_client_test::#{action}") }

  context 'the default action (:create)' do
    let(:action) { :default }

    shared_examples_for 'any attribute set' do
      it 'installs a x2go_client_app' do
        expect(chef_run).to install_x2go_client_app('default')
          .with(source: source)
      end
    end

    context 'the default attributes' do
      let(:source) { nil }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'
    end

    context 'a source attribute' do
      let(:source) { 'https://example.com/x2go.pkg' }
      cached(:chef_run) { converge }

      it_behaves_like 'any attribute set'
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'removes a x2go_client_app' do
      expect(chef_run).to remove_x2go_client_app('default')
    end
  end
end
