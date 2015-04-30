# need to set up java and mysql so we can actually do integration testing!
case node['platform_family']
when 'debian'
  package 'openjdk-7-jre-headless'
when 'rhel'
  package 'java-1.7.0-openjdk'
  package 'tar' # docker centos image doesn't come with tar.
end

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'changeme'
  action [:create] if node[:platform_family] == 'debian'
  action [:create, :start] if node[:platform_family] == 'rhel'
end

# Debian/Ubuntu with kitchen-docker do not support upstart, so just manually start for testing purposes!
execute 'hack-start mysql on debian in docker' do
 command '/usr/sbin/mysqld --defaults-file=/etc/mysql-default/my.cnf > /dev/null 2>&1 &'  
 only_if { node[:platform_family] == 'debian' }
end

# create a db & user/password to use below.
execute 'add test db info' do
  command "sleep 5s; /usr/bin/mysql -h 127.0.0.1 -uroot -pchangeme -e \"CREATE DATABASE testdb; GRANT ALL ON testdb.* to 'testuser' identified by 'testpassword';\""
end

#### Actual flyway migration definition ####
flyway 'default' do
  url 'jdbc:mysql://127.0.0.1:3306/testdb'
  user 'testuser'
  password 'testpassword'
  migrations 'migrations'
  additional_options(
    'placeholders.a' => 'a_here',
    'placeholders.b' => 'b_here'
  )
  action [:create, :migrate]
end
