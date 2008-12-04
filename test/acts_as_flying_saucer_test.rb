require 'test_helper'


class Foo < ActionController::Base
  
  acts_as_flying_saucer
  
end

class ActsAsFlyingSaucerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
