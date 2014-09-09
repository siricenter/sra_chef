#
# Cookbook Name:: sra
# Recipe:: default
#
# Copyright 2014, SIRI
#
# All rights reserved - Do Not Redistribute
#

install_dir = '/vagrant/sra'

bash 'trust_github' do
	user 'vagrant'
	cwd '/vagrant/sra'
	code <<-EOH
	 if [[ ! -a /home/vagrant/.ssh/known_hosts   ]]; then
		 echo "Add github.com to known_hosts"
		 touch /home/vagrant/.ssh/known_hosts && \
		 ssh-keyscan -H github.com >> /home/vagrant/.ssh/known_hosts && \
		 chmod 600 /home/vagrant/.ssh/known_hosts && \
		 chown vagrant /home/vagrant/.ssh/known_hosts
	 fi
	EOH
end

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
	rake db:create
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
