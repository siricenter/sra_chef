#
# Cookbook Name:: sra
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "/vagrant/sra" do
	repository "https://github.com/siricenter/sra"
	action :sync
	user "vagrant"
end	
