#
# Cookbook Name:: set-ssh-config
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node["ssh-config"]["hosts"].each do |config_info|
  template "set .ssh/config" do
    path "/home/#{node["ssh-config"]["user"]}/.ssh/config"
    source "ssh-config.erb"
    user node["ssh-config"]["user"]
    group node["ssh-config"]["group"]
    mode 0700
    variables({
      :ssh_host              => config_info['host'],
      :ssh_ip                => config_info['ip'],
      :ssh_user              => config_info['user'],
      :ssh_port              => config_info['port'],
      :ssh_identityfile_path => "/home/#{node["ssh-config"]["user"]}/" + config_info['identityfile_path'],
    })
  end

  template "set identityfile" do
    path "/home/#{node["ssh-config"]["user"]}/" + config_info['identityfile_path']
    source "ssh-identityfile.erb"
    user node["ssh-config"]["user"]
    group node["ssh-config"]["group"]
    mode 0700
    variables({
      :ssh_identityfile => config_info['identityfile']
    })
  end
end

