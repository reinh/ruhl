require 'ruhl'

module Sinatra
  module Templates
    def ruhl(template, options = {}, locals = {})
      require_warn('Ruhl') unless defined?(::Ruhl::Engine)

      render :ruhl, template, options, locals
    end

    private

    def render(engine, template, options={}, locals={})
      # merge app-level options
      options = self.class.send(engine).merge(options) if self.class.respond_to?(engine)

      # extract generic options
      layout = options.delete(:layout)
      layout = :layout if layout.nil? || layout == true
      views = options.delete(:views) || self.class.views || "./views"
      locals = options.delete(:locals) || locals || {}

      # render template
      data, options[:filename], options[:line] = lookup_template(engine, template, views)
      output = __send__("render_#{engine}", template, data, options, locals)

      # render layout
      if layout
        data, options[:filename], options[:line] = lookup_layout(engine, layout, views)
        if data
          output = __send__("render_#{engine}", layout, data, options, locals) { output }
        end
      end

      output
    end
    
    def render_ruhl(template, data, options, locals, &block)
      ::Ruhl::Engine.new(data, options).render(self)
    end
  end
end
