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
	repository "https://github.com/siricenter/sra"
	action :sync
	user "vagrant"
	not_if {File.exists? "/"}
end	

bash "run_bundler" do
	user 'vagrant'
	cwd install_dir
	command 'bundle'
	action :run
end

bash "run_server" do
	user 'vagrant'
	cwd install_dir
	command 'rails s -p 8000 -d'
	action :run
end
