#
# Cookbook: mesos-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

module MesosClusterCookbook
  module Resource
    class MesosConfig < Chef::Resource
      include Poise(fused: true)
      provides(:mesos_service)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:user, kind_of: String, default: 'mesos')
      attribute(:group, kind_of: String, default: 'mesos')

      action(:create) do

      end

      action (:delete) do

      end
    end
  end
end
