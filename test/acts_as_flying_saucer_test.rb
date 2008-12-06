require 'test_helper'


ActsAsFlyingSaucer::Config.options = {
  :java_bin => "java",
  :classpath_separator => ':',
  :tmp_path => "/tmp",
  :run_mode => :once
}

class FooController < ActionController::Base
  
  acts_as_flying_saucer
  
  def show
    render_pdf :template => 'foo'
  end
  
end

class ActsAsFlyingSaucerTest < ActiveSupport::TestCase
  
  def setup
    @controller = FooController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new 
  end
  
  def test_show
    get :show
    assert_response :success
  end
  
end
