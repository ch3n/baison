module Baison
  class Order < Base
    attr_accessor :sell_record_code, :order_status, :shipping_status,
                  :receiver_name, :receiver_address, :receiver_mobile,
                  :express_code, :express_no, :delivery_time,
                  :deal_code_list

    attr_reader :detail_list


    def detail_list=(args)
      a = Array.new
      args.each do |arg|
        begin
          a << ::Baison::OrderDetail.new(arg)
        rescue => error
          @logger.error(error)
          abort
        end

      end
      @detail_list = a
    end

    def details
      @detail_list
    end

    class << self
      def find(args)
        self.resource = "oms.order.search.get"
        super(args)
      end
    end

  end
end