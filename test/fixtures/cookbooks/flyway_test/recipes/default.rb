package "openjdk-7-jre-headless"
flyway 'sparky' do
  url 'jdbc:mysql://localhost:3306/sparky'
  user 'sparky'
  password 'sparky'
  migrations 'migrations'
  action [:create, :migrate]
end