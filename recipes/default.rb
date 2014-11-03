#
# Cookbook Name:: sra
# Recipe:: default
#
# Copyright 2014, SIRI
#
# All rights reserved - Do Not Redistribute
#

install_dir = '/vagrant/sra'
ruby_version = '2.0.0'

bash 'trust_github' do
	user 'vagrant'
	cwd '/home/vagrant'
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

bash 'create_/vagrant' do
	user 'root'
	cwd '/home/vagrant'
	code <<-EOH
	if [ ! -d /vagrant ]; then
		mkdir /vagrant
		chown "vagrant" "/vagrant"
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

bash "run_bundler" do
	user 'root'
	cwd install_dir
	code <<-EOH
	rvm use #{ruby_version};
	gem install bundler;
	bundle install;
	EOH
	action :run
end

bash 'setup_db' do
	user 'root'
	cwd '/vagrant/sra'
	code <<-EOH
	rvm use #{ruby_version};
	rake db:create;
	rake db:reset;
	EOH
end

bash "run_server" do
	user 'root'
	cwd install_dir
	code <<-EOH
	rvm use #{ruby_version};
	rails s -p 8000 -d;
	EOH
	action :run
	not_if {`ps aux | grep rail[s]` != ""}
end
