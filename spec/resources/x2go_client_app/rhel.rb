# encoding: utf-8
# frozen_string_literal: true

require_relative '../x2go_client_app'

shared_context 'resources::x2go_client_app::rhel' do
  include_context 'resources::x2go_client_app'

  shared_examples_for 'any RHEL platform' do
    context 'the default action (:install)' do
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
end
