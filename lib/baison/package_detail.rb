module Baison
  class PackageDetail < Base
    # @price 单价
    # @payment 实付金额
    attr_accessor :sku, :num, :price, :payment

    def attributes
      {
          :sku     => nil,
          :num     => nil,
          :price   => nil,
          :payment => nil
      }
    end
  end
end