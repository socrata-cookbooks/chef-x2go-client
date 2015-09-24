# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client_app_windows'

describe Chef::Provider::X2goClientApp::Windows do
  let(:name) { 'default' }
  let(:new_resource) { Chef::Resource::X2goClientApp.new(name, nil) }
  let(:provider) { described_class.new(new_resource, nil) }

  describe 'PATH' do
    it 'returns the correct application path' do
      expected = File.expand_path('/Program Files (x86)/x2goclient')
      expect(described_class::PATH).to eq(expected)
    end
  end

  describe 'URL' do
    it 'returns the correct download URL' do
      expected = 'http://code.x2go.org/releases/X2GoClient_latest_mswin32-' \
                 'setup.exe'
      expect(described_class::URL).to eq(expected)
    end
  end

  describe '.provides?' do
    let(:platform) { nil }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }
    let(:res) { described_class.provides?(node, new_resource) }

    context 'Windows' do
      let(:platform) { { platform: 'windows', version: '2012R2' } }

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
    it 'installs the X2go client package' do
      p = provider
      expect(p).to receive(:x2go_client_package).with(:install)
      p.send(:install!)
    end
  end

  describe '#remove!' do
    it 'removes the X2go client package' do
      p = provider
      expect(p).to receive(:x2go_client_package).with(:remove)
      p.send(:remove!)
    end
  end

  describe '#x2go_client_package' do
    let(:source) { nil }
    let(:new_resource) do
      r = super()
      r.source(source) unless source.nil?
      r
    end

    context 'no source attribute' do
      let(:source) { nil }

      it 'installs the X2go client package from the default source' do
        p = provider
        expect(p).to receive(:windows_package).with('X2Go Client for Windows')
          .and_yield
        expect(p).to receive(:source).with(described_class::URL)
        expect(p).to receive(:installer_type).with(:nsis)
        expect(p).to receive(:action).with(:install)
        p.send(:x2go_client_package, :install)
      end
    end

    context 'a source attribute' do
      let(:source) { '/tmp/x2go.exe' }

      it 'installs the X2go client package from the overridden source' do
        p = provider
        expect(p).to receive(:windows_package).with('X2Go Client for Windows')
          .and_yield
        expect(p).to receive(:source).with('/tmp/x2go.exe')
        expect(p).to receive(:installer_type).with(:nsis)
        expect(p).to receive(:action).with(:install)
        p.send(:x2go_client_package, :install)
      end
    end
  end
end
