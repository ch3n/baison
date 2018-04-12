require 'rake'
require 'baison'
namespace :stock do
  desc "export shop stock"
  task :export, [:key, :secret, :shop] do |t, args|
    Baison::Base.params = Baison::Params.new(
        args[:key],
        args[:secret],
        args[:shop]
    )

    page = 1
    while true
      skus = Baison::Stock.find_all({page: page})
      if skus.count == 0
        break
      end

      skus.each do |sku|
        print [sku.barcode_, sku.num].join("\t") + "\n"
      end

      page = page + 1
    end

  end

  task :show, [:key,:secret, :shop,:barcode] do |t,args|
    Baison::Base.params = Baison::Params.new(
        args[:key],
        args[:secret],
        args[:shop]
    )

    pp Baison::Stock.find({barcode: args[:barcode]})
  end
end
