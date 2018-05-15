$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "baison"

require "minitest/autorun"


class ActiveSupport::TestCase
  def before_setup
    key       = ''
    secret    = ''
    shop_code = ''
    if key.nil? || secret.nil? || shop_code.nil?

    end
    Baison::Base.params = Baison::Params.new(
        key,
        secret,
        shop_code
    )
  end
end