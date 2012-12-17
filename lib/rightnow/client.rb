require 'openssl'
require 'base64'
require 'faraday'
require 'json'

module Rightnow
  class Client
    attr_accessor :host, :api_key, :secret_key, :version

    def initialize host, opts = {}
      @host = host
      @api_key = opts[:api_key]
      @secret_key = opts[:secret_key]
      @version = opts[:version] || '2010-05-15'

      @conn = Faraday.new(:url => host) do |faraday|
#        faraday.response :logger
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def request action, opts = {}
      response = @conn.get 'api/endpoint', signed_params(action, opts)
      body = JSON.parse(response.body || '')
      if response.status != 200
        if body['error'].is_a?(Hash)
          raise Rightnow::Error.new(body['error']['message'], body['error']['code'])
        else
          raise Rightnow::Error.new("API returned #{response.status} without explanation: #{response.body}")
        end
      end
      body
    rescue JSON::ParserError
      raise Rightnow::Error.new("Bad JSON received: #{response.body.inspect}")
    end

  protected

    def signed_params action, opts = {}
      opts ||= {} if not opts.is_a? Hash
      params = {
        'Action' => action,
        'ApiKey' => api_key,
        'PermissionedAs' => opts.delete(:as) || 'hl_api',
        'SignatureVersion' => '2',
        'version' => version
      }
      signstr = params.keys.sort_by(&:downcase).map {|k| "#{k}#{params[k]}" }.join
      signature = Base64.strict_encode64(OpenSSL::HMAC::digest("sha1", secret_key, signstr))
      params.merge({
        'Signature' => signature,
        'format' => 'json'
      })
    end
  end
end