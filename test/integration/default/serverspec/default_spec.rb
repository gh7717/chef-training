require 'spec_helper'
describe "apache:default" do
  describe port(80) do
    it { should be_listening }
  end 
  describe process("apache2") do
    it{ should be_running  }
  end
  describe process("apache2") do
    its(:user) { should eq "root" }
  end
end
