class String
  def underscore
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

class Hash
  def underscore
    Hash[map { |k, v| [k.underscore, v] }]
  end
end