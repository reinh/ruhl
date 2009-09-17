module Sinatra
  module Templates
    def ruhl(template, options = {}, locals = {})
      require_warn('Ruhl') unless defined?(::Ruhl::Engine)

      render :ruhl, template, options, locals
    end

    private

    def render_ruhl(template, data, options, locals, &block)
      ::Ruhl::Engine.new(data).render(self)
    end
  end
end
