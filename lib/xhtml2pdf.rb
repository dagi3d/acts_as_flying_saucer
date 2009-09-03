# ActsAsFlyingSaucer
#
module ActsAsFlyingSaucer

  # Xhtml2Pdf
  #
  class Xhtml2Pdf
   
    # Xhtml2Pdf.write_pdf
    #
    def self.write_pdf(options)
     
      File.open(options[:input_file], 'w') do |file|
        file << options[:html]
      end

      if defined?(JRUBY_VERSION)
        input = options[:input_file]
        output = options[:output_file]
        url = java.io.File.new(input).toURI.toURL.toString

        os = java.io.FileOutputStream.new(output)

        renderer = org.xhtmlrenderer.pdf.ITextRenderer.new
        renderer.setDocument(url)
        renderer.layout
        renderer.createPDF(os)
        os.close
      else
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
end