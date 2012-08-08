require_recipe 'build-essential'

freetds_url  = 'ftp://ftp.freetds.org/pub/freetds/stable/freetds-0.91.tar.gz'
freetds_tar  = 'freetds-0.91.tar.gz'
freetds_dir  = 'freetds-0.91'
freetds_conf = '/usr/local/etc/freetds.conf'

package "wget" do
  action :install
end

execute "ldconfig" do
  user "root"
  action :nothing
end

execute "download freetds" do
  command "wget #{freetds_url}"
  cwd "/tmp"
  user "root"
  creates "/tmp/#{freetds_tar}"
end

execute "tar -zxf #{freetds_tar}" do
  cwd "/tmp"
  user "root"
  creates freetds_dir
end

execute "compile freetds" do
  command "./configure && make && make install"
  user "root"
  cwd "/tmp/#{freetds_dir}"
  creates "/usr/local/lib/libsybdb.so.5"
  notifies :run, resources(:execute => "ldconfig")
end

template freetds_conf do
  source "freetds.conf"
  owner "root"
  group "root"
  mode 0644
end
