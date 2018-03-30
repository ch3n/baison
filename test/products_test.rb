require 'test_helper'

class ProductsTest < ActiveSupport::TestCase

  def test_find_all_products
    products = Baison::Product.find_all({})
    assert products
  end

  def test_find_one_product
    product = Baison::Product.find_one({})
    assert product
  end

  def test_product_has_skus
    product = Baison::Product.find_one({})
    assert product.barcode_list
  end

  def test_product_has_stocks
    product = Baison::Product.find_one({})
    assert product.barcode_list.first.stock.num
  end

  def test_product_has_brand
    product = Baison::Product.find_one({})
    assert product.brand_name
    assert product.brand_code
  end
end