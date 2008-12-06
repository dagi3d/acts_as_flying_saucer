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