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
    def self.write_pdf(html)
      
      tmp_dir = ActsAsFlyingSaucer::Config.options[:tmp_path]
      input_file = tmp_dir + Time.new.to_i.to_s + ".html"
      
      File.open(input_file, 'w') do |file|
        file << html
      end
      
      output_file = "/Users/dagi3d/Desktop/foo.pdf"
      cp_separator = ActsAsFlyingSaucer::Config.options[:classpath_separator]
      
      java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
      
      class_path = ".:#{java_dir}/bin"

      Dir.glob("#{java_dir}/jar/*.jar") do |jar|
        class_path << "#{cp_separator}#{jar}"
      end

      command = "java -cp #{class_path} Xhtml2Pdf #{input_file} #{output_file}"
      system(command)
    end
  end
  
  # ClassMethods
  #
  module ClassMethods
    
    def acts_as_flying_saucer
      self.send(:include, ActsAsFlyingSaucer::InstanceMethods)
    end
    
  end
  
  # InstanceMethods
  #
  module InstanceMethods
  
    def render_pdf(options = {})
      html = render_to_string options
      # saving the file
      ActsAsFlyingSaucer::Xhtml2Pdf.write_pdf(html)
    end

    
    
  end
end
