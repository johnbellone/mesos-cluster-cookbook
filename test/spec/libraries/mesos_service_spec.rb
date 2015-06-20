require 'spec_helper'

describe_recipe 'mesos-cluster::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.new(step_into: %w{mesos_service}).converge(described_recipe) }

  context 'with default attributes' do
    it { expect(chef_run).to upgrade_package('mesos') }

    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['mesos-cluster']['service']['install_method'] = 'binary'" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: %w{mesos_service}) do |node|
        node.set['mesos-cluster']['service']['install_method'] = 'binary'
      end.converge(described_recipe)
    end

    it { expect(chef_run).not_to upgrade_package('mesos') }

    it 'converges successfully' do
      chef_run
    end
  end
end
