require_recipe 'mongo'

template '/etc/mongos.conf' do
  source 'mongos.conf'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/init/mongos.conf' do
  source 'upstart.conf'
  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file "/tmp/setup.js" do
  source "setup.js"
  mode "0644"
end

execute "setup" do
  cwd "/tmp/"
  command "mongo admin setup.js"
  action :run
end

