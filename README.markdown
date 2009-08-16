acts\_as\_flying\_saucer
=====================

acts\_as\_flying\_saucer is a Ruby On Rails plugin that allows to save rendered views as pdf documents using the [Flying Saucer][1] java library.

[1]: https://xhtmlrenderer.dev.java.net/

Install
-------

Grab the last version from Github:

    ./script/plugin install git://github.com/dagi3d/acts_as_flying_saucer.git


Requirements
------------

JDK 1.5.x or 1.6.x

It was developed under Mac OS X Leopard but it should work on any operating system with a compatible Java Virtual Machine

Usage
-----

Just call the acts\_as\_flying\_saucer method inside the controller you want to enable to generate pdf documents.
Then you can call the render\_pdf method. 
It accepts the same options as ActionController::Base#render plus the following ones:
  

:pdf\_file - absolute path for the generated pdf file.
  
:send\_file - sends the generated pdf file to the browser. It's the hash the ActionController::Streaming#send\_file method will receive.  
             
            
          
    class FooController < ActionController::Base
      acts_as_flying_saucer
    
      def create
        render_pdf :template => 'foo/pdf_template'
      end
    end
   

  
Examples
--------
  
    # Renders the template located at '/foo/bar/pdf.html.erb' and stores the pdf 
    # in the temp path with a filename based on its md5 digest
    render_pdf :file => '/foo/bar/pdf.html.erb'
  
    # renders the template located at 'app/views/foo.html.erb' and saves the pdf
    # in '/www/docs/foo.pdf'
    render_pdf :template => 'foo', :pdf_file => '/www/docs/foo.pdf'
  
    # renders the 'app/views/foo.html.erb' template, saves the pdf in the temp path
    # and sends it to the browser with the name 'bar.pdf'
    render_pdf :template => 'foo', :send_file => { :filename => 'bar.pdf' }
  
  
Easy as pie

While converting the xhtml document into a pdf, the css stylesheets and images should be referenced with absolute URLs(either local or remote) or Flying Saucer will not be able to access them. 
If there is no asset host defined, it will set automatically during the pdf generation so the parser can access the requested resources:

View rendered in the browser:

    <%= stylesheet_link_tag("styles.css") %>
    #<link href="/stylesheets/styles.css?1228586784" media="screen" rel="stylesheet" type="text/css" />


    <%= image_tag("rails.png") %>
    # <img alt="Rails" src="/images/rails.png?1228433051" />
  
View rendered as pdf:

    <%= stylesheet_link_tag("styles.css") %>
    #<link href="http://localhost:3000/stylesheets/styles.css" media="print" rel="stylesheet" type="text/css" />


    <%= image_tag("rails.png") %>
    # <img alt="Rails" src="http://localhost:3000/images/rails.png" />
  
The stylesheet media type will be set to 'print' if none was given(otherwise it would not be parsed)

If you need to distinguish if the view is being rendered in the browser or as a pdf, you can use the @pdf\_mode variable, whose value will be set to :create
when generating the pdf version

  
Configuration
-------------

These are the default settings which can be overwritten in your enviroment configuration file:

    ActsAsFlyingSaucer::Config.options = {
      :java_bin => "java",          # java binary
      :classpath_separator => ':',  # classpath separator. unixes system use ':' and windows ';'
      :tmp_path => "/tmp",          # path where temporary files will be stored
    }


Roadmap
-------

* Write a java application that listens to a port and sends the rendered view through sockets so there is no need to launch the jvm everytime a new pdf is generated
* Write a cache system for the pdf's
* Write some tests... (yes, I know it should be the first thing I should have done...)



Copyright (c) 2008-2009 Borja Martín Sánchez de Vivar <borjamREMOVETHIS@dagi3d.net> - <http://dagi3d.net>, released under the MIT license

