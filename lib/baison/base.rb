require 'active_model'

module Baison
  class Base
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    class_attribute :resource
    class_attribute :params


    attr_accessor :logger

    def initialize(args)
      @logger = Logger.new(STDOUT)
      super args
    end

    def save
      json = self.class.connection.post(self.resource, {}, self.as_json)
      self.class.new(json)
    end

    def attributes
      raise StandardError("define your model's attributes,return a hash")
    end


    class << self

      def find_all(args)
        find(args)
      end

      def find_one(args)
        args.merge!({page_size: 1})
        find(args).first
      end

      # @return [Baison::Connection]
      def connection
        Connection.new(self.params)
      end


      protected

      def find(options)
        a = Array.new
        json = connection.post(self.resource, options)
        if json['status'] != '1'
          raise ::StandardError.new(json)
        end
        begin
          data = json['data']['data']
        rescue
          raise ::StandardError.new(json)
        end


        if block_given?
          a = yield data
        else
          data.each do |row|
            a << self.new(row)
          end
        end
        a
      end

    end

    def _assign_attribute(k, v)
      if respond_to?("#{k}=")
        public_send("#{k}=", v)
      else
        # raise UnknownAttributeError.new(self, k)
      end
    end


  end
end
