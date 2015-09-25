# Encoding: UTF-8

require_relative '../spec_helper'

describe 'x2go-client::app' do
  describe ppa('x2go/stable'), if: os[:family] == 'ubuntu' do
    it 'is enabled' do
      expect(subject).to be_enabled
    end
  end

  describe package('x2goclient'), if: os[:family] != 'darwin' do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe file('/Applications/Utilities/XQuartz.app'),
           if: os[:family] == 'darwin' do
    it 'exists' do
      expect(subject).to be_directory
    end
  end

  describe file('/Applications/x2goclient.app'), if: os[:family] == 'darwin' do
    it 'exists' do
      expect(subject).to be_directory
    end
  end
end
