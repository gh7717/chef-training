#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved
package "apache2"
#package 'htop'
file "/var/www/html/index.html" do
  owner "apache"
  content "Hello World"
  group "apache"
end
service "apache2" do
  action [:start,:enable]
end
