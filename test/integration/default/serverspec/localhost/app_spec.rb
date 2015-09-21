# Encoding: UTF-8

require_relative '../spec_helper'

describe 'x2go-client::app' do
  describe ppa('x2go/stable'), if: os[:family] == 'ubuntu' do
    it 'is enabled' do
      expect(subject).to be_enabled
    end
  end

  describe package('x2goclient') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end
end
