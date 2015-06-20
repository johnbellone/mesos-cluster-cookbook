#
# Cookbook: mesos-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

node.default['java']['jdk_version'] = 7
include_recipe 'java::default'

poise_service_user node['mesos-cluster']['service_user'] do
  group node['mesos-cluster']['service_group']
end

config = mesos_config node['mesos-cluster']['service_name'] do |r|
  user node['mesos-cluster']['service_user']
  group node['mesos-cluster']['service_group']

  node['mesos-cluster']['config'].each_pair { |k, v| r.send(k ,v) }
  notifies :restart, "mesos_service[#{name}]", :delayed
end

mesos_service node['mesos-cluster']['service_name'] do |r|
  user node['mesos-cluster']['service_user']
  group node['mesos-cluster']['service_group']
  config_path config.path

  node['mesos-cluster']['service'].each_pair { |k, v| r.send(k ,v) }
end
