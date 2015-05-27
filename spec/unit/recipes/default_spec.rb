#
# Cookbook Name:: apache
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
    it 'install apache package'  do
      expect(chef_run).to install_package('apache2')
    end
#    it "create a /var/www/html/index.html file" do
#      expect(chef_run).to render_file('/var/www/html/index.html').with_content('Hello World')
#    end 
    it "start apache service" do
      expect(chef_run).to start_service('apache2')
    end
    it "enable apache service" do
      expect(chef_run).to enable_service('apache2')
    end
    it "check if /var/www/html/index.html file has a correct user" do
      expect(chef_run).to create_file('/var/www/html/index.html').with(:owner => "apache", group:"apache")
    end
#    it "check if /var/www/html/index.html file has a correct group" do
#      expect(chef_run).to create_file('/var/www/html/index.html').with(group:"apache")
#    end
  end
end
