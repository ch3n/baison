module Baison
  class Stock < Base
    attr_accessor :sku, :barcode, :num, :inv_update_time, :lastchange_time


    class << self
      def find(args)
        self.resource = "prm.goods.shop.inv"
        args.merge!({start_time: '1989-03-26 00:00:00', page_size: 100})
        super(args) do |data|
          array = []
          data.values.each do |v|
            array << self.new(v)
          end
          array
        end
      end
    end


    def barcode_
      barcode.to_s.upcase.gsub("FREE", "Free")
    end

  end
end