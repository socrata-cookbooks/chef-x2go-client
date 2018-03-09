# frozen_string_literal: true

if os.name == 'ubuntu'
  describe apt('ppa:x2go/stable') do
    it { should_not exist }
    it { should_not be_enabled }
  end
elsif os.name == 'debian'
  describe apt('http://packages.x2go.org/debian') do
    it { should_not exist }
    it { should_not be_enabled }
  end
elsif os.redhat?
  describe yum.repo('epel') do
    it { should exist }
    it { should be_enabled }
  end
end

if os.darwin?
  describe directory('/Applications/Utilities/XQuartz.app') do
    it { should_not exist }
  end

  describe directory('/Applications/x2goclient.app') do
    it { should_not exist }
  end
else
  describe package('x2goclient') do
    it { should_not be_installed }
  end
end
