# ActsAsFlyingSaucer
module ActsAsFlyingSaucer
  
  # Config
  #
  class Config
    cattr_accessor :options
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  
  private
  
  # Xhtml2Pdf
  #
  class Xhtml2Pdf
    def self.write_pdf
      puts File.expand_path(File.dirname(__FILE__))
    end
  end
  
  # ClassMethods
  #
  module ClassMethods
    
    def acts_as_flying_saucer
      self.send(:include, ActsAsFlyingSaucer::InstanceMethods)
      class_eval do 
        alias_method_chain :render, :pdf
      end
    end
    
  end
  
  # InstanceMethods
  #
  module InstanceMethods
=begin
    def render_pdf(options = {})
      html = render_to_string options
      # saving the file
      ActsAsFlyingSaucer::Xhtml2Pdf.write_pdf
    end
=end
    
    def render_with_pdf(options = nil, extra_options = {}, &block)
      
      render_without_pdf(options, extra_options, &block)
    end
    
  end
end
