require_recipe 'build-essential'

mongo_url  = 'http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.0.2.tgz'
mongo_tar  = 'mongodb-linux-x86_64-2.0.2.tgz'
mongo_dir  = 'mongodb-linux-x86_64-2.0.2'

package "wget" do
  action :install
end

remote_file "/tmp/#{mongo_tar}" do
  source "#{mongo_url}"
  mode 0644
  action :create_if_missing
end

execute "tar -xf #{mongo_tar}" do
  cwd "/tmp"
  user "root"
  creates mongo_dir
end

%w(bsondump  mongo  mongod  mongodump  mongoexport  mongofiles
  mongoimport  mongorestore  mongos  mongosniff  mongostat  mongotop).each do |file|

  execute "copy #{file}" do
    cwd "/tmp/#{mongo_dir}"
    command "cp #{file} /usr/bin/"
    creates "/usr/bin/#{file}"
    action :run
  end
end

user "mongodb" do
  system true
end

group "mongodb" do
  members ['mongodb']
end

directory "/var/log/mongodb" do
  owner "mongodb"
  group "mongodb"
  mode "0755"
  action :create
end

#Copy key file
cookbook_file "/home/ubuntu/keyfile.txt" do
  source "keyfile.txt"
  mode "0600"
end

