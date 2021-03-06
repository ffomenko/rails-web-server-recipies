mongo_tar  = 'mongodb-linux-x86_64-2.0.2.tgz'
mongo_dir  = 'mongodb-linux-x86_64-2.0.2'

remote_file "/tmp/#{mongo_tar}" do
  source 'http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.0.2.tgz'
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
    cwd "/tmp/#{mongo_dir}/bin"
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

#logrotate
template '/etc/logrotate.d/mongodb' do
  source 'mongo_logrotate'
  owner 'root'
  group 'root'
  mode 0644
end

directory "/home/ubuntu" do
  owner "mongodb"
  group "mongodb"
end

#Copy key file
cookbook_file "/home/ubuntu/keyfile.txt" do
  source "keyfile.txt"
  mode "0600"
  owner "mongodb"
  group "mongodb"
end


