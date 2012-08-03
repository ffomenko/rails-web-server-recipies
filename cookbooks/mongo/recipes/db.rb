require_recipe 'mongo'
#require_recipe 'raid'

template '/etc/mongodb.conf' do
  source 'mongodb_db.conf'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/init/mongodb.conf' do
  source 'upstart_db.conf'
  owner 'root'
  group 'root'
  mode 0644
end

# Copy initialization json
cookbook_file "/tmp/setup-db.js" do
  source "setup_db.js"
  mode "0644"
end

## For debugging
directory "/data" do
  owner "mongodb"
  group "mongodb"
  mode "0755"
  action :create
end

service "mongodb" do
  provider Chef::Provider::Service::Upstart
  action :start
end

execute "setup mongodb" do
  cwd "/tmp"
  command "mongo localhost:27018/admin setup-db.js"
  action :run
end

