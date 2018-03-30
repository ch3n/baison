module Baison
  class OrderDetail < Base
    attr_accessor :goods_code, :goods_name, :spec1_code, :spec1_name, :spec2_code, :spec2_name, :barcode, :num

    alias_method :color, :spec1_name
    alias_method :size, :spec2_name
  end
end