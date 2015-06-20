#
# Cookbook: mesos-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

class Chef::Resource::MesosService < Chef::Resource
  include Poise
  provides(:mesos_service)
  include PoiseService::ServiceMixin

  attribute(:service_name, kind_of: String, name_attribute: true)
  attribute(:user, kind_of: String, default: 'mesos')
  attribute(:group, kind_of: String, default: 'mesos')

  attribute(:install_method, equal_to: %w{package binary}, default: 'binary')
  attribute(:package_name, kind_of: String, default: 'mesos')
  attribute(:package_version, kind_of: String)
end

class Chef::Provider::MesosService < Chef::Provider
  include Poise
  provides(:mesos_service)
  include PoiseService::ServiceMixin

  def action_enable
    notifying_block do
      package new_resource.package_name do
        options '--no-install-recommends' if node['platform'] == 'debian'
        version new_resource.package_version unless new_resource.package_version.nil?
        action :upgrade
        only_if { new_resource.install_method == 'package' }
      end

      ark 'mesos' do
        only_if { new_resource.install_method == 'binary' }
      end
    end
    super
  end

  def action_disable
    notifying_block do

    end
    super
  end
end
