if defined?(ChefSpec)
  # config
  def create_flyway(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:flyway, :create, resource_name)
  end
end
