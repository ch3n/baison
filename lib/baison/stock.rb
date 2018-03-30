module Baison
  class Stock < Base
    attr_accessor :sku, :barcode, :num, :inv_update_time, :lastchange_time


    class << self
      def find(args)
        self.resource = "prm.goods.shop.inv"
        args.merge!({start_time: '1989-03-26 00:00:00'})
        super(args) do |data|
          array = []
          array << self.new(data.values.first)
          array
        end
      end
    end

  end
end