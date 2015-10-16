# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_x2go_client_app_ubuntu'

describe Chef::Provider::X2goClientApp::Ubuntu do
  let(:name) { 'default' }
  let(:run_context) { ChefSpec::SoloRunner.new.converge.run_context }
  let(:new_resource) { Chef::Resource::X2goClientApp.new(name, run_context) }
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

    context 'Debian' do
      let(:platform) { { platform: 'debian', version: '7.6' } }

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
      [:include_recipe, :repository, :package].each do |m|
        allow_any_instance_of(described_class).to receive(m)
      end
    end

    shared_examples_for 'any attribute set' do
      it 'ensures the APT cache is up to date' do
        p = provider
        expect(p).to receive(:include_recipe).with('apt')
        p.send(:install!)
      end
    end

    context 'no source attribute' do
      let(:source) { nil }

      it_behaves_like 'any attribute set'

      it 'adds the X2go APT repository' do
        p = provider
        expect(p).to receive(:repository).with(:add)
        p.send(:install!)
      end

      it 'installs the default X2go client package' do
        p = provider
        expect(p).to receive(:package).with('x2goclient')
        p.send(:install!)
      end
    end

    context 'a source attribute' do
      let(:source) { '/tmp/package.deb' }

      it_behaves_like 'any attribute set'

      it 'does not add the X2go APT repository' do
        p = provider
        expect(p).to_not receive(:repository)
        p.send(:install!)
      end

      it 'installs the X2go client package from the source' do
        p = provider
        expect(p).to receive(:package).with('/tmp/package.deb')
        p.send(:install!)
      end
    end
  end

  describe '#remove!' do
    before(:each) do
      [:package, :repository].each do |m|
        allow_any_instance_of(described_class).to receive(m)
      end
    end

    it 'removes the X2go client package' do
      p = provider
      expect(p).to receive(:package).with('x2goclient').and_yield
      expect(p).to receive(:action).with(:remove)
      p.send(:remove!)
    end

    it 'removes the X2go APT repository' do
      p = provider
      expect(p).to receive(:repository).with(:remove)
      p.send(:remove!)
    end
  end

  describe '#repository' do
    let(:platform) { { platform: 'ubuntu', version: '14.04' } }
    let(:node) { ChefSpec::Macros.stub_node('node.example', platform) }

    before(:each) do
      allow_any_instance_of(described_class).to receive(:node).and_return(node)
    end

    it 'returns an apt_repository resource' do
      p = provider
      expect(p).to receive(:apt_repository).with('x2go').and_yield
      expect(p).to receive(:uri).with('ppa:x2go/stable')
      expect(p).to receive(:distribution).with('trusty')
      expect(p).to receive(:action).with(:add)
      p.send(:repository, :add)
    end
  end
end
