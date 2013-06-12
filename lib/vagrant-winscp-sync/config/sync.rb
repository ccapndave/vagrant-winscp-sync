module VagrantPlugins
  module WinSCP
    module Config
      class Sync < Vagrant.plugin("2", :config)
        attr_accessor :session
        attr_accessor :local_dir
        attr_accessor :remote_dir
        attr_accessor :file_mask

        def initialize
          super
          @session = UNSET_VALUE
          @local_dir = UNSET_VALUE
          @remote_dir = UNSET_VALUE
          @file_mask = UNSET_VALUE
        end

        def finalize!
          @local_dir = Dir.pwd if @local_dir == UNSET_VALUE
          @file_mask = "*" if @local_dir == UNSET_VALUE
        end

        def validate(machine)
          return { "session" => ["The WinSCP session must be set"] } if (@session == UNSET_VALUE)
          return { "remote_dir" => ["The remote dir must be set"] } if (@remote_dir == UNSET_VALUE)
          return {}
        end

      end
    end
  end
end