require_recipe 'mongo'

template '/etc/mongos.conf' do
  source 'mongos.conf'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/init/mongos.conf' do
  source 'upstart_mongos.conf'
  owner 'root'
  group 'root'
  mode 0644
end

service "mongods" do
  provider Chef::Provider::Service::Upstart
  action :start
end

cookbook_file "/tmp/setup-shard.js" do
  source "setup-shard.js"
  mode "0644"
end

execute "setup" do
  cwd "/tmp/"
  command "mongo localhost:27018/admin setup-shard.js"
  action :run
  only_if { sleep(60); true}
end

