if defined?(ChefSpec)
  def create_jail(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jail, :create, resource_name)
  end
end
