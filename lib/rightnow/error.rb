module Rightnow
  class Error < StandardError
    def initialize msg, code = nil
      super msg
      @code = code
    end

    def to_s
      super + (@code.nil? ? '' : " (#{@code})")
    end
  end

  class JsonParseError < StandardError; end
end