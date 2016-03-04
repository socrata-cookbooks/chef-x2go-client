# Encoding: UTF-8

source 'https://supermarket.chef.io'

metadata

group :unit do
  cookbook 'resource_x2go_client_test',
           path: 'spec/support/cookbooks/resource_x2go_client_test'
  cookbook 'resource_x2go_client_app_test',
           path: 'spec/support/cookbooks/resource_x2go_client_app_test'
end

group :integration do
  cookbook 'x2go-client_test', path: 'test/fixtures/cookbooks/x2go-client_test'
end
