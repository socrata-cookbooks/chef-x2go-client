# encoding: utf-8
# frozen_string_literal: true

require_relative '../x2go_client_app'

shared_context 'resources::x2go_client_app::fedora' do
  include_context 'resources::x2go_client_app'

  shared_examples_for 'any Fedora platform' do
    context 'the default action (:install)' do
      include_context description

      context 'the default properties' do
        include_context description

        it 'installs the x2goclient package' do
          expect(chef_run).to install_package('x2goclient')
        end
      end

      context 'a source property' do
        include_context description

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
