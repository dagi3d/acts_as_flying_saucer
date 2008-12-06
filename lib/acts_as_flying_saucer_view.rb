module ActionView
  
  module Helpers
    module AssetTagHelper
      # class AssetTag redefinition
      #
      class AssetTag
        
        # the cache key should be constructed considering the pdf_mode
        #
        def initialize(template, controller, source, include_host = true)
        
          @template = template
          @controller = controller
          @source = source
          @include_host = include_host
          @cache_key = if controller.respond_to?(:request)
            [self.class.name,controller.request.protocol,
             ActionController::Base.asset_host,
             ActionController::Base.relative_url_root,
             source, include_host, @controller.pdf_mode]
          else
            [self.class.name,ActionController::Base.asset_host, source, include_host, @controller.pdf_mode]
          end
        end
        
        private
        # compute_public_path
        #
        def compute_public_path(source)
          
          if source =~ ProtocolRegexp
            source += ".#{extension}" if missing_extension?(source)
            source = prepend_asset_host(source)
            source
          else
            CacheGuard.synchronize do
              Cache[@cache_key] ||= begin    
                source += ".#{extension}" if missing_extension?(source) || file_exists_with_extension?(source)
                source = "/#{directory}/#{source}" unless source[0] == ?/
                source = rewrite_asset_path(source) unless @controller.pdf_mode == :create
                source = prepend_relative_url_root(source)                
                source = prepend_asset_host(source)
                if @controller.pdf_mode == :create
                  source = "file://#{RAILS_ROOT}/public/#{source}"
                end
                source
              end
            end 
          end
        end # compute_public_path
      end # AssetTag
    end # AssetTagHelper
  end # Helpers
end # ActionView