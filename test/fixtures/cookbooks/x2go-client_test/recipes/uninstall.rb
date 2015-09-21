# Encoding: UTF-8

include_recipe 'x2go-client'

x2go_client 'default' do
  action :remove
end
