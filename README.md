# Rightnow

Ruby wrapper for the Oracle Rightnow Social API v2

## Installation

Add this line to your application's Gemfile:

    gem 'rightnow'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rightnow

## Usage

Instanciate a new client with your community url and API keys:

```ruby
client = Rightnow::Client.new "http://community.company.com", :api_key => "YOUR_PUBLIC_KEY", :secret_key => "YOUR_PRIVATE_KEY"
```

Then you can query the API with:

```ruby
client.request 'UserList', :as => 'admin@domain.com'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
