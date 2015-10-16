# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client'

describe Chef::Provider::X2goClient do
  let(:name) { 'default' }
  let(:run_context) { ChefSpec::SoloRunner.new.converge.run_context }
  let(:new_resource) { Chef::Resource::X2goClient.new(name, run_context) }
  let(:provider) { described_class.new(new_resource, run_context) }

  describe '.provides?' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }
    let(:res) { described_class.provides?(node, new_resource) }

    context 'Ubuntu' do
      let(:platform) { { platform: 'ubuntu', version: '14.04' } }

      it 'returns true' do
        expect(res).to eq(true)
      end
    end
  end

  describe '#whyrun_supported?' do
    it 'returns true' do
      expect(provider.whyrun_supported?).to eq(true)
    end
  end

  describe '#action_create' do
    before(:each) do
      allow_any_instance_of(described_class).to receive(:x2go_client_app)
    end

    it 'installs the X2go client app' do
      p = provider
      expect(p).to receive(:x2go_client_app).with(name).and_yield
      expect(p).to receive(:source).with(nil)
      p.action_create
    end
  end

  describe '#action_remove' do
    before(:each) do
      allow_any_instance_of(described_class).to receive(:x2go_client_app)
    end

    it 'removes the X2go client app' do
      p = provider
      expect(p).to receive(:x2go_client_app).with(name).and_yield
      expect(p).to receive(:action).with(:remove)
      p.action_remove
    end
  end
end
