require 'openssl'
require 'base64'
require 'faraday'

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
      @conn.get 'api/endpoint', signed_params(action, opts)
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