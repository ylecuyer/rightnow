require 'rightnow'
require 'webmock/rspec'

RSpec.configure do |config|
  config.color = true
end

# Simple helper loading fixture content and applying choosen parser
# ex:
# fixture('post.rb', :ruby) will eval the file as ruby code and return the last value
def fixture file, parser=nil
  res = File.read("spec/fixtures/#{file}")
  res = eval(res) if parser == :ruby
  res = JSON.parse(res) if parser == :json
  res
end