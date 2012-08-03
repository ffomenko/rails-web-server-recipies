require_recipe 'build-essential'

mdadm "/dev/md0" do
  devices ['/dev/xvdp4', '/dev/xvdp5',  '/dev/xvdp6',  '/dev/xvdp7']
  level 10
  chunk 256
  action [ :create, :assemble ]
end

# mdm config file?

directory "/data" do
  owner "mongodb"
  group "mongodb"
  mode "0755"
  action :create
end

mount "/data" do
  device "/dev/md0"
  fstype "ext4"
end
