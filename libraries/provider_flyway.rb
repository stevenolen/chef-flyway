require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class Flyway < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      include FlywayCookbook::Helpers

      action :create do
        # create path for resource
        dir = new_resource.path || "/opt/flyway-#{new_resource.name}/"
        directory dir do
          recursive true
        end
        # get flyway package, extract it
        remote_file "#{Chef::Config[:file_cache_path]}/flyway-commandline-#{new_resource.version}.tar.gz" do
          source flyway_remote_url
          notifies :run, "bash[#{new_resource.name}: extract flyway tar]", :immediately 
        end
        bash "#{new_resource.name}: extract flyway tar" do
          cwd Chef::Config[:file_cache_path]
          code "tar xf flyway-commandline-#{new_resource.version}.tar.gz -C #{dir} --strip-components=1"
          action :nothing
        end
        #flyway conf file template
        template "#{new_resource.name}: create flyway conf" do
          cookbook 'flyway'
          path "#{dir}conf/flyway.conf"
          source 'flyway.conf.erb'
          variables(
            resource: new_resource
          )
        end

        # flyway migration directory
        remote_directory "#{new_resource.name}: create migrations" do
          source new_resource.migrations
        end
        

      end

      action :migrate do
        execute "#{new_resource.name}: perform migrations" do
          command flyway_migrate_cmd
          only_if { flyway_validate_cmd }
        end
      end
    end
  end
end