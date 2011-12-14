module Slim
  # Temple filter which processes embedded engines
  # @api private
  class EmbeddedEngine < Temple::Filters::EmbeddedEngine

    # Sass engine which supports :pretty option
    class SassEngine < TiltEngine
    protected
      def tilt_render(tilt_engine, tilt_options, name, content)
        _, content = super( tilt_engine, {:style => (options[:pretty] ? :expanded : :compressed), :cache => false}.merge(tilt_options), name, content )
        content.chomp!
        if options[:pretty]
          content = "\n#{content}\n"
        end
        return [:static, content]
      end
    end

    # These engines are shipped with slim by default, but this implementation uses :pretty
    register :sass,       SassEngine, :pretty
    register :scss,       SassEngine, :pretty

  end
end
