# need to set up java and mysql so we can actually do integration testing!
package 'openjdk-7-jre-headless'
mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'changeme'
  action [:create]
end
# Debian/Ubuntu with kitchen-docker do not support upstart, so just manually start for testing purposes!
execute '/usr/sbin/mysqld --defaults-file=/etc/mysql-default/my.cnf > /dev/null 2>&1 &'
execute "sleep 5s; /usr/bin/mysql -h 127.0.0.1 -uroot -pchangeme -e \"CREATE DATABASE testdb; GRANT ALL ON testdb.* to 'testuser' identified by 'testpassword';\""

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
