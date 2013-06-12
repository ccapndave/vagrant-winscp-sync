module VagrantPlugins
  module WinSCP
    module Provisioner
      class Sync < Vagrant.plugin("2", :provisioner)

        # Initializes the provisioner with the machine that it will be
        # provisioning along with the provisioner configuration (if there
        # is any).
        #
        # The provisioner should _not_ do anything at this point except
        # initialize internal state.
        #
        # @param [Machine] machine The machine that this will be provisioning.
        # @param [Object] config Provisioner configuration, if one was set.
        def initialize(machine, config)
          super
        end

        # Called with the root configuration of the machine so the provisioner
        # can add some configuration on top of the machine.
        #
        # During this step, and this step only, the provisioner should modify
        # the root machine configuration to add any additional features it
        # may need. Examples include sharing folders, networking, and so on.
        # This step is guaranteed to be called before any of those steps are
        # done so the provisioner may do that.
        #
        # No return value is expected.
        def configure(root_config)
          @machine.ui.info "Configure"
        end

        # This is the method called when the actual provisioning should be
        # done. The communicator is guaranteed to be ready at this point,
        # and any shared folders or networks are already setup.
        #
        # No return value is expected.
        def provision
          @machine.ui.info "Provision"
        end

      end
    end
  end
end