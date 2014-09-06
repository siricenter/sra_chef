#
# Cookbook Name:: sra
# Recipe:: default
#
# Copyright 2014, SIRI
#
# All rights reserved - Do Not Redistribute
#

install_dir = '/vagrant/sra'

git install_dir do
	repository "git@github.com:siricenter/sra.git"
	action :sync
	user "vagrant"
	revision "master"
	not_if {File.exists? install_dir}
end	

gem_package "bundler" do
	version "1.7.2"
	action :install
end

bash 'setup_db' do
	user 'vagrant'
	cwd '/vagrant/sra'
	code <<-EOH
	rake db:reset
	EOH
end

bash "run_bundler" do
	user 'vagrant'
	cwd install_dir
	code <<-EOH
	bundle install
	EOH
	action :run
end

bash "run_server" do
	user 'vagrant'
	cwd install_dir
	code <<-EOH
	rails s -p 8000 -d
	EOH
	action :run
	not_if {`ps aux | grep rail[s]` != ""}
end
