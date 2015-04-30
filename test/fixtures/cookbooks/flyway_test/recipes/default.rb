flyway 'default' do
  url 'jdbc:mysql://localhost:3306/testdb'
  user 'testuser'
  password 'testpassword'
  migrations 'migrations'
  action [:create, :migrate]
end
