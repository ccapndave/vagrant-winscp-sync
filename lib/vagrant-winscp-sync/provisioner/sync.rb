require 'open3'

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

        end

        # This is the method called when the actual provisioning should be
        # done. The communicator is guaranteed to be ready at this point,
        # and any shared folders or networks are already setup.
        #
        # No return value is expected.
        def provision
          session = @config.session
          local_dir = @config.local_dir
          remote_dir = @config.remote_dir
          file_mask = @config.file_mask

          open_command = "open \"\"#{session}\"\""
          sync_command = "synchronize remote \"\"#{local_dir}\"\" \"\"#{remote_dir}\"\" -filemask=\"\"#{file_mask}\"\" "

          run_cmd [ "\"C:\\Program Files (x86)\\WinSCP\\winscp.com\" /console /command \"#{open_command}\" \"#{sync_command}\" " ]

          #u2d_command = "keepuptodate \"\"#{local_dir}\"\" \"\"#{remote_dir}\"\" -filemask=\"\"#{file_mask}\"\" "
          #Process.spawn "\"C:\\Program Files (x86)\\WinSCP\\winscp.com\" /console /command \"#{open_command}\" \"#{u2d_command}\" "
        end

        def run_cmd(cmd)
          @machine.ui.info "running: #{cmd.join ' '}"
          Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thread|
            stdin.close
            readers = [stdout, stderr]
            while not readers.empty?
              rs, = IO.select(readers)
              break if rs.empty?
              rs.each do |r|
                begin
                  got = r.readpartial(1024)
                  out = (r == stdout) ? $stdout : $stderr
                  out.print got
                rescue EOFError
                  readers.delete_if { |s| r == s }
                end
              end
            end
            wait_thread.value.success?
          end
        end

      end
    end
  end
end