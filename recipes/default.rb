#
# Cookbook Name:: sra
# Recipe:: default
#
# Copyright 2014, SIRI
#
# All rights reserved - Do Not Redistribute
#

install_dir = '/vagrant/sra'
packages = %w(ruby ruby-dev)

packages.each do |program|
	package program
end

git install_dir do
	repository "git@github.com:siricenter/sra.git"
	action :sync
	user "vagrant"
	not_if {File.exists? install_dir}
end	

gem_package "bundler" do
	version "1.5.2"
	action :install
end

bash "run_bundler" do
	user 'root'
	cwd install_dir
	code <<-EOH
	bundle install
	EOH
	action :run
end

bash "run_server" do
	user 'vagrant'
	cwd install_dir
	command 'rails s -p 8000 -d -debugger'
	action :run
end
