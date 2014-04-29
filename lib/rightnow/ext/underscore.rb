def convert_hash_keys(value)
  case value
    when Array
      value.map { |v| convert_hash_keys(v) }
    when Hash
      Hash[value.map { |k, v| [k.underscore, convert_hash_keys(v)] }]
    else
      value
   end
end

class Hash
  def underscore
    convert_hash_keys(self)
  end
end

# backport
require 'active_support'
class String
  # http://apidock.com/rails/String/underscore
  # File activesupport/lib/active_support/core_ext/string/inflections.rb, line 118
  def underscore
    ActiveSupport::Inflector.underscore(self)
  end
end