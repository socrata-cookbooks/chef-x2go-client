# frozen_string_literal: true

require_relative '../x2go_client_app'

describe 'resources::x2go_client_app::rhel' do
  include_context 'resources::x2go_client_app'

  shared_examples_for 'any RHEL platform' do
    context 'the :install action' do
      include_context description

      shared_examples_for 'any property set' do
        it 'configures EPEL' do
          expect(chef_run).to include_recipe('yum-epel')
        end
      end

      context 'the default properties' do
        include_context description

        it_behaves_like 'any property set'

        it 'installs the x2goclient package' do
          expect(chef_run).to install_package('x2goclient')
        end
      end

      context 'a source property' do
        include_context description

        it_behaves_like 'any property set'

        it 'installs the source package' do
          expect(chef_run).to install_package(source)
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes the x2goclient package' do
        expect(chef_run).to remove_package('x2goclient')
      end
    end
  end

  RSpec.configuration.supported_platforms.each do |os, versions|
    next unless %i[centos redhat].include?(os)

    context os.to_s.capitalize do
      let(:platform) { os.to_s }

      versions.each do |ver|
        context ver do
          let(:platform_version) { ver }

          it_behaves_like 'any RHEL platform'
        end
      end
    end
  end
end
