require 'rake'
require 'baison'

namespace :package do
  desc "index"
  task :index, [:key, :secret, :shop] do |t, args|
    Baison::Base.params = Baison::Params.new(
        args[:key],
        args[:secret],
        args[:shop]
    )
    page = 1
    provinces = {}
    while true
      orders = Baison::Order.find_all({page: page, page_size: 100, shipping_status: 4, start_delivery_time: '2018-01-01 00:00:00'})
      unless orders.count
        break
      end
      orders.each do |order|
        pp order.receiver_province
        if provinces["#{order.receiver_province}"].nil?
          provinces["#{order.receiver_province}"] = 1
        else
          provinces["#{order.receiver_province}"] += 1
        end
      end
      page = page + 1
    end
    pp provinces

  end
end
