# frozen_string_literal: true

module DumpedRailers
  module Configuration
    extend Forwardable
    def_delegators :@_config, :preprocessors, :ignorable_columns

    def configure
      yield config
    end

    def options
      config.to_h.deep_dup
    end

    IGNORABLE_COLUMNS = %w[id created_at updated_at]
    def configure_defaults!
      clear_configuration!(
        ignorable_columns: IGNORABLE_COLUMNS,
        preprocessors:     []
      )
    end

    def config
      @_config ||= OpenStruct.new
    end
    private :config

    def clear_configuration!(**attrs)
      @_config = OpenStruct.new(attrs)
    end
    private :clear_configuration!
  end
end
