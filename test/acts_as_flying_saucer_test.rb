require 'test_helper'


class FooController < ActionController::Base
  
  acts_as_flying_saucer
  
  def show
    render_pdf :template => 'foo', :pdf_file => "/Users/dagi3d/Desktop/foo.pdf"
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
