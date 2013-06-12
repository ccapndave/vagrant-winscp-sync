begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant WinSCP sync plugin must be run within Vagrant."
end

if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant AWS plugin is only compatible with Vagrant 1.2+"
end

module VagrantPlugins
  module WinSCP
    class Plugin < Vagrant.plugin("2")
      name "WinSCP"

      provisioner(:winscp_sync) do
        require File.expand_path("../provisioner/sync", __FILE__)
        Provisioner::Sync
      end
    end
  end
end