flyway 'default' do
  url 'jdbc:mysql://localhost:3306/testdb'
  user 'testuser'
  password 'testpassword'
  migrations 'migrations'
  additional_options(
    'placeholders.a' => 'a_here',
    'placeholders.b' => 'b_here'
  )
  action [:create, :migrate]
end
