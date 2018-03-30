require 'net/http'
require 'json'
require 'uri'
require 'digest'

module Baison
  class Connection
    attr_accessor :params
    attr_accessor :site

    # @param [Baison::Params] params
    def initialize(params)
      @params = params
      @site   = URI(@params.site)
    end

    # body 其实一直是空的，虽然接口要求POST，但是GET也不是不可以，所有参数都是经过url传过去 WTF
    def post(resource, params = {}, body = {})
      check_resource resource
      request(build_url(resource, params), body: body)
    end

    private

    def check_resource(resource)
      raise ArgumentError, "resource is required" unless resource.presence
      raise ArgumentError, "resource should be string" unless resource.kind_of?(String)
    end

    def request(url, **args)
      http         = Net::HTTP.new(@site.host, @site.port)
      request      = Net::HTTP::Post.new(URI(url), {'Content-Type' => 'text/json'})
      request.body = args[:body].to_json.to_s
      response     = http.request(request)
      ::JSON.parse(response.body)
    end

    def build_url(resource, params = {})
      p     = build_params(params, resource)
      query = build_query(p)
      sign  = sign(p)
      @site.to_s + "&" + query + "&sign=" + sign
    end

    def sign(params = {})
      str = ""
      params.each do |k, v|
        str += "#{k}#{v}"
      end
      str = "#{self.params.secret}#{str}#{self.params.secret}"
      Digest::MD5.hexdigest(str).upcase
    end

    def build_params(params, method)
      p = {
          method:      method,
          format:      @params.format,
          key:         @params.key,
          sign_method: @params.sign_method,
          v:           @params.v,
          shop_code:   @params.shop_code,
          timestamp:   Time.now.strftime('%Y-%m-%d %H:%M:%S')
      }
      p.merge!(params)
      p.sort.to_h
    end

    def build_query(params)
      p = ""
      params.each do |k, v|
        v = CGI.escape(v.to_s)
        p += "#{k}=#{v}&"
      end
      p
    end
  end
end
