#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved
package "apache2"
#package 'htop'
file "/var/www/index.html" do
  owner "root"
  content "Hello World"
  group "root"
end
service "apache2" do
  action [:start,:enable]
end
