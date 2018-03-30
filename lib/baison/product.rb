module Baison
  class Product < Base
    attr_accessor :goods_code, :goods_name, :brand_code, :brand_name
    validates :goods_code, :goods_name, :brand_code, :brand_name, presence: true

    attr_reader :barcode_list


    def barcode_list=(args)
      a = Array.new
      args.each do |arg|
        begin
          a << ::Baison::Sku.new(arg)
        rescue => error
          @logger.error(error)
          abort
        end

      end
      @barcode_list = a
    end


    class << self
      def find(args)
        self.resource = "prm.goods.list"
        super(args)
      end
    end
  end
end