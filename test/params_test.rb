require 'test_helper'


class ParamsTest < ActiveSupport::TestCase
  def test_build_params
    params = Baison::Params.new('616623385f5e6a171af55ed73c217c6c', '062e2fdef023d220dc4dfe22ebca922a', 'ht017')
    assert params
  end
end