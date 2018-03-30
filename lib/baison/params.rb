module Baison
  class Params
    attr_accessor :site, :key, :secret, :format, :v, :sign_method, :page_size, :shop_code

    def initialize(key, secret, shop_code)
      @site   = "http://openapi.baotayun.com/openapi/webefast/web/?app_act=openapi/router"
      @format = "json"
      # @timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      @v           = "2.1"
      @sign_method = "md5"
      @page_size   = 20

      @key       = key
      @secret    = secret
      @shop_code = shop_code

      if @key.nil? or @secret.nil? or @shop_code.nil?
        raise ArgumentError, "key,secret,shop_code are required"
      end
    end
  end
end