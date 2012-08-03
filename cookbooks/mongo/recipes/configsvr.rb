require_recipe 'mongo'

template '/etc/mongodb_db.conf' do
  source 'mongodb_configsvr.conf'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/init/mongodbconfigsvr.conf' do
  source 'upstart_configsvr.conf'
  owner 'root'
  group 'root'
  mode 0644
end

directory "/data" do
  owner "mongodb"
  group "mongodb"
  mode "0755"
  action :create
end

mount "/data" do
  device "/dev/sdf"
  fstype "ext4"
end

