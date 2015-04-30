# flyway-cookbook

LWRP for creating [flyway](http://flywaydb.org) migrations. Spec, and integration tested!

## Supported Platforms

Should work work on *nix, full test suite for Ubuntu and Centos.

## Usage

### flyway

Include a flyway block in your wrapper cookbook which configures your app/database. the `migrations` attribute is a pointer to a directory of files in
your wrapper cookbook with your properly named flyway migrations. If you need more than just the jdbc url, user and password (such as placeholders, 
specific schemas, etc.) please take a look at the `additional_options` hash in addition to all available on 
[this page](http://flywaydb.org/documentation/commandline/migrate.html). Each item listed in `additional_options` will have `flyway.` prepended 
to it prior to placing it in the config file, so no need to do it yourself. The `:create` and `:migrate` options are intentionally separated for flexibility.
Please note, however, that the `:migrate` action has been properly guarded for idempotency (using the output from `flyway validate` to ensure it is not execute
on every chef run)

```ruby
flyway 'default' do
  url 'jdbc:mysql://127.0.0.1:3306/testdb'
  user 'testuser'
  password 'testpassword'
  migrations 'migrations' #see the flyway_test fixtures cookbook for an example of this
  additional_options(
    'placeholders.a' => 'a_here',
    'placeholders.b' => 'b_here'
  )
  action [:create, :migrate]
end

```

## License and Authors

Author:: Steve Nolen (<technolengy@gmail.com>)
