require 'spec_helper'

describe 'Java' do
  describe command('java -version 2>&1') do
    its(:exit_status) { should eq 0 }
  end
end

describe 'Postgresql' do
  describe service('postgresql') do
    it { should be_running }
  end

  describe port(5432) do
    it { should be_listening }
  end
end

describe 'JIRA' do
  describe port(8080) do
    it { should be_listening }
  end

  describe command("curl --noproxy localhost 'http://localhost:8080/secure/SetupApplicationProperties!default.jspa' | grep 'JIRA Setup'") do
    its(:exit_status) { should eq 0 }
  end
end
