require "baison/version"
require 'active_support'

module Baison
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Product
  autoload :Sku
  autoload :Stock
  autoload :Order
  autoload :OrderDetail
  autoload :Package
  autoload :PackageDetail
  autoload :Params
  autoload :Connection
end
