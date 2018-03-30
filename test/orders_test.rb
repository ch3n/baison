require 'test_helper'

class OrdersTest < ActiveSupport::TestCase
  def test_find_order
    order = Baison::Order.find_one({})
    pp order.deal_code_list
  end

  def test_order_has_detail
    order = Baison::Order.find_one({})
    assert order.details
  end
end
