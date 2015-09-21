# Encoding: UTF-8

require_relative '../spec_helper'

describe 'x2go-client::default' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'creates an x2go_client resource' do
    expect(chef_run).to create_x2go_client('default')
  end
end
