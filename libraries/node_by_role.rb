module Spadeworks
  module Openstack
    def node_by_role(role)
      result, _, _ = Chef::Search::Query.new.search(:node, "roles:#{role}")
      if result.empty?
        if node['roles'].include?(role)
          return node
        end

        Chef::Log.fatal "Cannot find node for role '#{role}'"
        return nil
      end

      return result[0]
    end
  end
end

