# Encoding: UTF-8

require_relative '../spec_helper'

describe 'x2go-client::app' do
  describe ppa('x2go/stable'), if: os[:family] == 'ubuntu' do
    it 'does not exist' do
      expect(subject).to_not exist
    end
  end

  describe package('x2goclient'), if: os[:family] != 'darwin' do
    it 'is not installed' do
      expect(subject).to_not be_installed
    end
  end

  describe file('/Applications/x2goclient.app'), if: os[:family] == 'darwin' do
    it 'does not exist' do
      expect(subject).to_not be_directory
    end
  end
end
