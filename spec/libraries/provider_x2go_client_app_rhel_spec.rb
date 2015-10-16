# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client_app_rhel'

describe Chef::Provider::X2goClientApp::Rhel do
  let(:name) { 'default' }
  let(:run_context) { ChefSpec::SoloRunner.new.converge.run_context }
  let(:new_resource) { Chef::Resource::X2goClientApp.new(name, run_context) }
  let(:provider) { described_class.new(new_resource, run_context) }

  describe '.provides?' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }
    let(:res) { described_class.provides?(node, new_resource) }

    context 'Red Hat' do
      let(:platform) { { platform: 'redhat', version: '7.0' } }

      it 'returns true' do
        expect(res).to eq(true)
      end
    end

    context 'CentOS' do
      let(:platform) { { platform: 'centos', version: '7.0' } }

      it 'returns true' do
        expect(res).to eq(true)
      end
    end
  end

  describe '#install!' do
    let(:source) { nil }
    let(:new_resource) do
      r = super()
      r.source(source) unless source.nil?
      r
    end

    before(:each) do
      [:include_recipe, :repository, :package].each do |m|
        allow_any_instance_of(described_class).to receive(m)
      end
    end

    shared_examples_for 'any attribute set' do
      it 'configures EPEL' do
        p = provider
        expect(p).to receive(:include_recipe).with('yum-epel')
        p.send(:install!)
      end
    end

    context 'no source attribute' do
      let(:source) { nil }

      it_behaves_like 'any attribute set'

      it 'installs the default X2go client package' do
        p = provider
        expect(p).to receive(:package).with('x2goclient')
        p.send(:install!)
      end
    end

    context 'a source attribute' do
      let(:source) { '/tmp/package.deb' }

      it_behaves_like 'any attribute set'

      it 'installs the X2go client package from the source' do
        p = provider
        expect(p).to receive(:package).with('/tmp/package.deb')
        p.send(:install!)
      end
    end
  end

  describe '#remove!' do
    it 'removes the X2go client package' do
      p = provider
      expect(p).to receive(:package).with('x2goclient').and_yield
      expect(p).to receive(:action).with(:remove)
      p.send(:remove!)
    end
  end
end
