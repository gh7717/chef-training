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
  conf_dir = "/etc/apache2/conf.d"
  package 'net-tools'
when '14.04'
  path="/var/www/html/index.html"
  conf_dir="/etc/apache2/conf-enabled"
end

directory "/var/www/admin/html" do
  recursive true
end

template "#{conf_dir}/admin.conf" do
  source "apache.erb"
  variables(port: 8080, document_root: "/var/www/admin/html")
  notifies :restart, "service[apache2]", :immediately
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
