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