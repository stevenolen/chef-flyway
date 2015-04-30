require 'serverspec'

set :backend, :exec

describe file('/opt/flyway-default/') do
  it { should be_directory }
end

describe file('/opt/flyway-default/conf/flyway.conf') do
  its(:content) { should match /flyway.url=jdbc:mysql:\/\/127.0.0.1:3306\/testdb/}
  its(:content) { should match /flyway.user=testuser/} 
  its(:content) { should match /flyway.password=testpassword/}
  its(:content) { should match /flyway.placeholders.a=a_here/}
  its(:content) { should match /flyway.placeholders.b=b_here/}
end

describe command('/opt/flyway-default/flyway validate') do
  its(:stdout) { should match /Validated 2 migrations/ }
end
