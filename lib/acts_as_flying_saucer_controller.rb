# ActsAsFlyingSaucer
module ActsAsFlyingSaucer
  
  module Controller
    
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
        self.send(:include, ActsAsFlyingSaucer::Controller::InstanceMethods)
        class_eval do
          attr_accessor :pdf_mode
        end
      end
    end
  
    # InstanceMethods
    #
    module InstanceMethods
      
      # render_pdf
      #
      def render_pdf(options = {})
        
        self.pdf_mode = :create
        html = render_to_string options
        self.pdf_mode = nil
           
        # saving the file
        tmp_dir = ActsAsFlyingSaucer::Config.options[:tmp_path]
        html_digest = Digest::MD5.hexdigest(html)
        input_file = "#{tmp_dir}/#{html_digest}.html"
        
        logger.debug("html file: #{input_file}")
      
        output_file = (options.has_key?(:pdf_file)) ? options[:pdf_file] : "#{tmp_dir}/#{html_digest}.pdf"
      
        generate_options = ActsAsFlyingSaucer::Config.options.merge({
          :input_file => input_file, 
          :output_file => output_file,
          :html => html
        })

        ActsAsFlyingSaucer::Xhtml2Pdf.write_pdf(generate_options)
      
        # sending the file to the client
        if options[:send_file]
        
          send_file_options = {
            :filename => File.basename(output_file),
            :x_sendfile => true,
          }
          
          send_file_options.merge!(options[:send_file]) if options.respond_to?(:merge)
        
          send_file(output_file, send_file_options)
        end
      end
    end
  end
 
end
