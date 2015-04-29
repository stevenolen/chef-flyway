require 'chef/provider/lwrp_base'
#require_relative 'helpers'

class Chef
  class Provider
    class Flyway < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      #include Flyway::Helpers

      action :create do
        # create path for resource
        dir = new_resource.path || "/opt/flyway-#{new_resource.name}/"
        directory dir do
          recursive true
        end
        # get flyway package, extract it
        remote_file "#{Chef::Config[:file_cache_path]}/flyway-commandline-#{new_resource.version}.tar.gz" do
          source "http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/#{new_resource.version}/flyway-commandline-#{new_resource.version}.tar.gz"
        end
        bash "#{new_resource.name}: extract flyway tar" do
          cwd Chef::Config[:file_cache_path]
          code "tar xf flyway-commandline-#{new_resource.version}.tar.gz -C #{dir} --strip-components=1"
        end
        

      end
    end
  end
end