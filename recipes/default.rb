package 'ubuntu-cloud-keyring'

apt_repository "openstack-updates" do
    uri node[:openstack][:cloud_archive_url]
    distribution "#{node[:lsb][:codename]}-updates/havana"
    components ['main']
end

