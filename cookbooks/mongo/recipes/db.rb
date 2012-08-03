require_recipe 'mongo'
require_recipe 'raid'

template '/etc/mongodb.conf' do
  source 'mongodb.conf'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/init/mongodb.conf' do
  source 'upstart.conf'
  owner 'root'
  group 'root'
  mode 0644
end

# Copy initialization json
cookbook_file "/tmp/setup.js" do
  source "setup.js"
  mode "0644"
end

execute "setup mongodb" do
  cwd "/tmp/"
  command "mongo admin setup.js"
  action :run
end

