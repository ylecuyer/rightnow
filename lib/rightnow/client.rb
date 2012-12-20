require 'openssl'
require 'base64'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
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
        #faraday.response :logger
        faraday.adapter  :typhoeus
      end
    end

    # Send a search query, returning an array of Rightnow::Post
    # results are limited to a few fields
    #
    # opts::
    #   A hash of options accepted by Rightnow's Search method
    #
    # returns::
    #   An array of Rightnow::Post
    #
    # example:
    #   +search :term => 'white', :sort => 'az', :limit => 50, :page => 1+
    #
    def search opts = {}
      opts[:limit] ||= 20
      opts[:objects] ||= 'Posts'
      opts[:start] ||= (opts[:page] - 1) * opts[:limit] + 1 if opts[:page]
      results = request 'Search', opts
      results.map {|r| Rightnow::Post.new(r.underscore) }
    end

    # Retrieve full details for one or more posts.
    # Run multiple queries in parallel.
    #
    # posts::
    #   Either a single element or an array of Rightnow::Post or post hash
    #
    # returns::
    #   A single element or an array of Rightnow::Post
    #   depending on the argument (single value or array)
    #
    # example::
    #   +post_get ["fa8e6cc713", "fa8e6cb714"]+
    #
    def post_get posts
      responses = nil
      @conn.in_parallel do
        responses = [posts].flatten.map do |post|
          hash = post.is_a?(Post) ? post.hash : post
          @conn.get 'api/endpoint', signed_params('PostGet', 'postHash' => hash)
        end
      end
      result = responses.zip([posts].flatten).map do |res, post|
        data = parse(res).underscore['post']
        if post.is_a? Post
          post.attributes = data
          post
        elsif data.is_a? Hash
          Rightnow::Post.new(data.merge(:hash => post))
        else
          nil
        end
      end
      posts.is_a?(Array) ? result : result.first
    end

    def request action, opts = {}
      parse @conn.get('api/endpoint', signed_params(action, opts))
    end

  protected

    def parse response
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
      }).merge(opts)
    end
  end
end