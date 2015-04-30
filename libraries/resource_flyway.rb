require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class Flyway < Chef::Resource::LWRPBase
      self.resource_name = :flyway
      actions :create, :migrate, :delete
      default_action :create

      attribute :instance, kind_of: String, name_attribute: true
      attribute :url, kind_of: String, required: true
      attribute :user, kind_of: String, required: true
      attribute :password, kind_of: String, required: true
      attribute :path, kind_of: String, default: nil
      attribute :version, kind_of: String, default: '3.2.1'
      attribute :migrations, kind_of: String, default: nil
      attribute :additional_options, kind_of: Hash, default: nil
      # location to java? might need this for really general support?
    end
  end
end
