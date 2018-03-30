module Baison
  class Sku < Base
    attr_accessor :goods_code, :spec1_code, :spec1_name, :spec2_code, :spec2_name, :sku, :barcode, :gb_code
    alias_method :color, :spec1_name
    alias_method :color_code, :spec1_code
    alias_method :size, :spec2_name
    alias_method :size_code, :spec2_code


    def stock
      @stock ||= ::Baison::Stock.find_one({barcode: @barcode})
    end
  end
end