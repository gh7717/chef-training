#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved
#require 'pry'
#binding.pry

package 'apache2'
case node['platform_version']
when '12.04'
  path="/var/www/index.html" 
when '14.04'
  path="/var/www/html/index.html"
end



template "/etc/apache2/conf-enabled/admin.conf" do
  source "apache.erb"
  variables(port: 8080, document_root: "/var/www/admin/html")
  notifies :restart, "service[apache2]"
end

directory "/var/www/admin/html/" do
  recursive true
end

file "/var/www/admin/html/index.html" do
  owner "root"
  content "Hello admin"
  group "root"
end

file "#{path}" do
  owner "root"
  content "Hello World"
  group "root"
end
service "apache2" do
  action [:start,:enable]
end
