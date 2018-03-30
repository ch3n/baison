$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "baison"

require "minitest/autorun"


class ActiveSupport::TestCase
  def before_setup
    Baison::Base.params = Baison::Params.new(
        '616623385f5e6a171af55ed73c217c6c',
        '062e2fdef023d220dc4dfe22ebca922a',
        'ht016'
    )
  end
end