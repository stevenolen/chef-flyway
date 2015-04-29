# flyway-cookbook

Configures `n` instances of flyway on a particular node to perform migrations.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

## Usage

### flyway

```ruby
flyway 'default' do
  url 'jdbc:mysql://localhost:3306/default'
  user 'defaultuser'
  password 'defaultpassword'
  #TODO: figure out how to handle placeholders
end

```

## License and Authors

Author:: Steve Nolen (<technolengy@gmail.com>)
