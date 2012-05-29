include_recipe "freetds"
include_recipe "apache2"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_rewrite"
include_recipe "passenger_apache2::mod_rails"

cookbook_file '/etc/ssl/certs/web1.dev1.liferisks.rms.com.crt' do
  owner 'root'
  group 'root'
  mode 0600
end

cookbook_file '/etc/ssl/private/web1.dev1.liferisks.rms.com.key' do
  owner 'root'
  group 'root'
  mode 0600
end

web_app "liferisks" do
  docroot "/var/www/liferisks"
  server_name "web1.dev1.liferisks.rms.com"
  rails_env "development"
end
