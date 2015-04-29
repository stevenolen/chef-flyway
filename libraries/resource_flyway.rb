require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class Flyway < Chef::Resource::LWRPBase
      self.resource_name = :flyway
      actions :create, :delete
      default_action :create

      attribute :instance, kind_of: String, name_attribute: true
      attribute :url, kind_of: String, required: true
      attribute :user, kind_of: String, required: true
      attribute :password, kind_of: String, required: true
      attribute :path, kind_of: String, default: nil
      attribute :version, kind_of: String, default: '3.2.1'
      # custom_download_url? might be odd since zip/targz and version attribute above
      # location to java?
    end
  end
end