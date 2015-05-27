#
# Cookbook Name:: apache
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'


RSpec.shared_examples "an apache server running an apache service" do
  it "converge succesfully" do
    chef_run
  end
end

describe 'apache::default' do
  context 'When all attributes are default, on an Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end



    it_should_behave_like "an apache server running an apache service"


    it 'converges successfully' do
      chef_run # This should not raise an error
    end
    it 'install apache package'  do
      expect(chef_run).to install_package('apache2')
    end
    it "start apache service" do
      expect(chef_run).to start_service('apache2')
    end
    it "enable apache service" do
      expect(chef_run).to enable_service('apache2')
    end
    it "check if /var/www/html/index.html file has a correct user" do
      expect(chef_run).to create_file('/var/www/html/index.html').with(:owner => "root", group:"root")
    end


    it "curl localhost:8080" do
      describe command "curl localhost:8080" do
        its(:stdout) { should match("Hello admin") } 
      end
    end 
    it "apache should be restarted" do
      resource = chef_run.template('/etc/apache2/conf-enabled/admin.conf')
      expect(resource).to notify('service[apache2]').to(:restart).immediately
    end

  end

  context 'When all attributes are default, on an Ubuntu 12.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
    it 'install apache package'  do
      expect(chef_run).to install_package('apache2')
    end
    it "start apache service" do
      expect(chef_run).to start_service('apache2')
    end
    it "enable apache service" do
      expect(chef_run).to enable_service('apache2')
    end
    it "check if /var/www/index.html file has a correct user" do
      expect(chef_run).to create_file('/var/www/index.html').with(:owner => "root", group:"root")
    end
  end

end


