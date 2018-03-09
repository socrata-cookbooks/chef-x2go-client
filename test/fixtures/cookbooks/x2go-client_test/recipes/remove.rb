# frozen_string_literal: true

include_recipe 'x2go-client'

x2go_client 'default' do
  action :remove
end
