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

cookbook_file "sra_db_setup.sql" do
	path '/home/vagrant'
	source 'sra_db_setup.sql'
	action :create_if_missing
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
	code <<-EOH
	rails s -p 8000 -d -debugger
	EOH
	action :run
	not_if {`ps aux | grep rail[s]` != ""}
end

bash 'setup_db' do
	user 'vagrant'
	cwd '/home/vagrant'
	code <<-EOH
	mysql -uroot -p < sra_db_setup.sql
	cd /vagrant/sra
	rake db:migrate
	EOH
end

