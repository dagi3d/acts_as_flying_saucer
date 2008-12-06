# ActsAsFlyingSaucer
module ActsAsFlyingSaucer
  
  # Config
  #
  class Config
    # default options
    @@options = {
      :java_bin => "java",
      :classpath_separator => ':',
      :tmp_path => "/tmp",
      :run_mode => :once
    }
    
    cattr_accessor :options
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  private
  # ClassMethods
  #
  module ClassMethods
    
    # acts_as_flying_saucer
    #
    def acts_as_flying_saucer
      self.send(:include, ActsAsFlyingSaucer::InstanceMethods)
    end
  end
  
  # InstanceMethods
  #
  module InstanceMethods
  
    # render_pdf
    #
    def render_pdf(options = {})
      html = render_to_string options
      
      # saving the file
      tmp_dir = ActsAsFlyingSaucer::Config.options[:tmp_path]
      html_digest = Digest::MD5.hexdigest(html)
      input_file = "#{tmp_dir}/#{html_digest}.html"
      
      output_file = (options.has_key?(:pdf_file)) ? options[:pdf_file] : "#{tmp_dir}/#{html_digest}.pdf"
      
      generate_options = ActsAsFlyingSaucer::Config.options.merge({
        :input_file => input_file, 
        :output_file => output_file,
        :html => html
      })

      ActsAsFlyingSaucer::Xhtml2Pdf.write_pdf(generate_options)
    end

  end
  
  # Xhtml2Pdf
  #
  class Xhtml2Pdf
    
    # Xhtml2Pdf.write_pdf
    #
    def self.write_pdf(options)
      
      File.open(options[:input_file], 'w') do |file|
        file << options[:html]
      end
      
      java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
      
      class_path = ".:#{java_dir}/bin"

      Dir.glob("#{java_dir}/jar/*.jar") do |jar|
        class_path << "#{options[:classpath_separator]}#{jar}"
      end

      command = "#{options[:java_bin]} -cp #{class_path} Xhtml2Pdf #{options[:input_file]} #{options[:output_file]}"
      system(command)
    end
  end
end
