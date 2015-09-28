# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client_app_fedora'

describe Chef::Provider::X2goClientApp::Fedora do
  let(:name) { 'default' }
  let(:new_resource) { Chef::Resource::X2goClientApp.new(name, nil) }
  let(:provider) { described_class.new(new_resource, nil) }

  describe '.provides?' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }
    let(:res) { described_class.provides?(node, new_resource) }

    context 'Fedora' do
      let(:platform) { { platform: 'fedora', version: '22' } }

      it 'returns true' do
        expect(res).to eq(true)
      end
    end

    context 'CentOS' do
      let(:platform) { { platform: 'centos', version: '7.0' } }

      it 'returns false' do
        expect(res).to eq(false)
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

    context 'no source attribute' do
      let(:source) { nil }

      it 'installs the default X2go client package' do
        p = provider
        expect(p).to receive(:package).with('x2goclient')
        p.send(:install!)
      end
    end

    context 'a source attribute' do
      let(:source) { '/tmp/package.deb' }

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
