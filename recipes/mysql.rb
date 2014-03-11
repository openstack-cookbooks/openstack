::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

connection_info = {
    :username => "root",
    :password => node[:mysql][:server_root_password],
}

databases = %w{keystone glance nova neutron}
databases.each do |db|
    mysql_database db do
        connection connection_info
    end

    node.set_unless[:openstack][:mysql]["#{db}_password"] = secure_password

    mysql_database_user db do
        connection connection_info
        password node[:openstack][:mysql]["#{db}_password"]
        database_name db
        host '%'
        privileges [:all]
        action [:create, :grant]
    end
end
