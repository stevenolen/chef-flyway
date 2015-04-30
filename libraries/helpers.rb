module FlywayCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def flyway_remote_url
      # needs to build from provided attribute if possible.
      "http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/#{new_resource.version}/flyway-commandline-#{new_resource.version}.tar.gz"
    end

    def flyway_migrate_cmd
      @flyway_bin = new_resource.path || "/opt/flyway-#{new_resource.instance}/"
      @flyway_bin += '/flyway'
      @cmd = @flyway_bin + ' migrate'
      @cmd
    end

    def flyway_validate_cmd
      @flyway_bin = new_resource.path || "/opt/flyway-#{new_resource.instance}/"
      @flyway_bin += '/flyway'
      @cmd = @flyway_bin + ' validate'
      @cmd
    end
  end
end
