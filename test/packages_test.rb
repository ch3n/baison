require 'test_helper'

class PackagesTest < ActiveSupport::TestCase
  def test_create_package
    package = package_data
    unless package.save
      pp package.errors
    end
  end

  protected

  def package_data
    data           = {
        shop_code:         Baison::Package.params.shop_code,
        status:            1,
        receiver_province: "上海市",
        receiver_city:     "上海市",
        receiver_district: "长宁区",
        receiver_addr:     "tian shan soho",
        receiver_name:     "chenz",
        pay_type:          "0",
        pay_time:          Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        receiver_mobile:   "18514280020",
        deal_code:         Time.now.strftime('%Y-%m-%d-%H-%M-%S'),
        buyer_remark:      "寒塘渡鹤影,冷月葬花魂",
        buyer_name:        "chenz",
        record_time:       Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        order_money:       "99",
        goods_num:         1
    }
    package        = Baison::Package.new(data)
    package.detail = package_detail_data
    package
  end

  def package_detail_data
    [
        {
            sku:     '2711Free',
            num:     1,
            price:   69.00,
            payment: 69.00
        }
    ].map do |item|
      Baison::PackageDetail.new(item)
    end

  end
end