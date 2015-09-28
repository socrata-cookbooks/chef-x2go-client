# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client_app_mac_os_x'

describe Chef::Provider::X2goClientApp::MacOsX do
  let(:name) { 'default' }
  let(:new_resource) { Chef::Resource::X2goClientApp.new(name, nil) }
  let(:provider) { described_class.new(new_resource, nil) }

  describe 'PATH' do
    it 'returns the correct application path' do
      expect(described_class::PATH).to eq('/Applications/x2goclient.app')
    end
  end

  describe '.provides?' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }
    let(:res) { described_class.provides?(node, new_resource) }

    context 'Mac OS X' do
      let(:platform) { { platform: 'mac_os_x', version: '10.10' } }

      it 'returns true' do
        expect(res).to eq(true)
      end
    end

    context 'Ubuntu' do
      let(:platform) { { platform: 'ubuntu', version: '14.04' } }

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

    before(:each) do
      allow_any_instance_of(described_class).to receive(:remote_path)
        .and_return('http://example.com/x2go.dmg')
      [:include_recipe, :dmg_package].each do |m|
        allow_any_instance_of(described_class).to receive(m)
      end
    end

    shared_examples_for 'any attribute set' do
      it 'installs XQuartz' do
        p = provider
        expect(p).to receive(:include_recipe).with('xquartz')
        p.send(:install!)
      end
    end

    context 'no source attribute' do
      let(:source) { nil }

      it_behaves_like 'any attribute set'

      it 'downloads and installs a remote package' do
        p = provider
        expect(p).to receive(:dmg_package).with('x2goclient').and_yield
        expect(p).to receive(:source).with('http://example.com/x2go.dmg')
        p.send(:install!)
      end
    end

    context 'a source attribute' do
      let(:source) { '/tmp/package.dmg' }

      it_behaves_like 'any attribute set'

      it 'installs the X2go client package from the source' do
        p = provider
        expect(p).to receive(:dmg_package).with('x2goclient').and_yield
        expect(p).to receive(:source).with('/tmp/package.dmg')
        p.send(:install!)
      end
    end
  end

  describe '#remove!' do
    before(:each) do
      allow_any_instance_of(described_class).to receive(:directory)
    end

    it 'deletes the application dir' do
      p = provider
      expect(p).to receive(:directory).with('/Applications/x2goclient.app')
        .and_yield
      expect(p).to receive(:recursive).with(true)
      expect(p).to receive(:action).with(:delete)
      p.send(:remove!)
    end
  end

  describe '#remote_path' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }

    before(:each) do
      allow_any_instance_of(described_class).to receive(:node).and_return(node)
    end

    context 'OS X 10.10' do
      let(:platform) { { platform: 'mac_os_x', version: '10.10' } }

      it 'returns the >=10.9 package URL' do
        expected = 'http://code.x2go.org/releases/X2GoClient_latest_macosx_' \
                   '10_9.dmg'
        expect(provider.send(:remote_path)).to eq(expected)
      end
    end

    context 'OS X 10.8.2' do
      let(:platform) { { platform: 'mac_os_x', version: '10.8.2' } }

      it 'returns the <10.9 package URL' do
        expected = 'http://code.x2go.org/releases/X2GoClient_latest_macosx.dmg'
        expect(provider.send(:remote_path)).to eq(expected)
      end
    end
  end
end
