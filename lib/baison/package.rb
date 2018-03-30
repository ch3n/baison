module Baison
  class Package < Base
    attr_accessor :shop_code, :status, :receiver_province, :receiver_city, :receiver_district, :receiver_addr, :receiver_name,
                  :pay_type, :pay_time, :receiver_mobile, :deal_code, :buyer_remark, :buyer_name,
                  :record_time, :order_money, :detail

    attr_writer :goods_num

    validates :shop_code, :status, :receiver_province, :receiver_city, :receiver_district, :receiver_addr, :receiver_name,
              :pay_type, :pay_time, :receiver_mobile, :deal_code, :buyer_remark, :buyer_name,
              :record_time, :order_money, :goods_num, :detail, presence: true


    def attributes
      {
          :shop_code         => nil,
          :status            => nil,
          :receiver_province => nil,
          :receiver_city     => nil,
          :receiver_district => nil,
          :receiver_addr     => nil,
          :receiver_name     => nil,
          :pay_type          => nil,
          :pay_time          => nil,
          :receiver_mobile   => nil,
          :deal_code         => nil,
          :buyer_remark      => nil,
          :buyer_name        => nil,
          :record_time       => nil,
          :order_money       => nil,
          :goods_num         => nil,
      }
    end

    def goods_num
      detail.sum(&:num)
    end

    def save
      unless valid?
        return false
      end
      self.resource = 'oms.api.order.add'
      json          = self.as_json
      json.merge!(detail: detail.as_json.to_json.to_s)
      json = self.class.connection.post(self.resource, json)
      pp json
      unless json["status"] == 1
        if json["data"].is_a? Array
          json["data"].each do |item|
            errors.add(item, :invalid, :message => [json["message"]])
          end
        end

      end
      json["status"] == 1
    end
  end
end