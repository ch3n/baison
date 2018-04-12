# Baison

百胜 efast 365 接口，实现了商品 品牌 sku 库存 订单相关的接口
每个接口的可用查询参数参考 efast [文档](http://operate.baotayun.com:8080/efast365-help/?p=2578)

## 安装

在 Gemfile 中添加:

```ruby
gem 'baison'
```

执行

    $ bundle

或者

    $ gem install baison

## 使用

### 初始化

设定 key secret shop_code
```ruby
Baison::Base.params = Baison::Params.new(key,secret,shop_code)
```

### 商品
```ruby
Baison::Product.find_all({page:1,page_size:100,lastchanged_start:'2018-04-01 00:00:00'})

Baison::Product.find_one({barcode: '1234567'})
```
efast 接口 prm.goods.list


### 品牌
商品查询中，每个 Product 都有一个 brand_code brand_name 属性

### sku
商品查询中，每个 Product 都有一个 barcode_list 属性，既是 sku 信息，返回一个 Array of Baison::Sku
默认情况下 spec1 是颜色，sepc2 是尺码
如果你的 spec 不一样，可以继承一个 Sku 进行自定义

### 库存
库存默认使用“计算库存”，即根据百胜系统运营策略得到的可用库存数
每个 Baison::Sku 都有 stock 熟悉，返回一个 Baison::Stock
也可以通过 barcode 自己查询库存
```ruby
Baison::Stock.find_all({barcode: '123456789'})

Baison::Stock.find_all({start_time: '2018-04-01 00:00:00'})
```
efast 接口 prm.goods.shop.inv


### 订单查询
```ruby
Baison::Order.find_one({deal_code: '123456'})

Baison::Order.find_all({deal_code: 1,shipping_status: 0})

Baison::Order 的属性 details 为 Baison::OrderDetail

```
efast 接口 oms.order.search.get

### 创建订单
```ruby
# 创建订单
package = Baison::Package.new({
        shop_code:         Baison::Package.params.shop_code,
        status:            1,
        receiver_province: "shanghai",
        receiver_city:     "shanghai",
        receiver_district: "changning",
        receiver_addr:     "tian shan soho",
        receiver_name:     "name",
        pay_type:          "0",
        pay_time:          Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        receiver_mobile:   "1851428xxxx",
        deal_code:         Time.now.strftime('%Y-%m-%d-%H-%M-%S'),
        buyer_remark:      "寒塘渡鹤影,冷月葬花魂",
        buyer_name:        "name",
        record_time:       Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        order_money:       "99",
    })

# 创建订单明细
details = [Baison::PackageDetail.new({
            sku:     '2711Free',
            num:     1,
            price:   69.00,
            payment: 69.00
        })]
package.details = details

# 保存订到到 efast
unless package.save
    pp package.errors
end
```
