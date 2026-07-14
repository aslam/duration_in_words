# frozen_string_literal: true

module DurationInWords
  module Methods
    extend self

    VALID_FORMATS = %i[compact full].freeze

    def duration_in_words(duration, options = {})
      raise_type_error(duration) unless duration.is_a?(ActiveSupport::Duration)

      locale, scope = parse_options(options)
      parts = duration.parts

      return I18n.t(:seconds, count: duration.value, scope: scope, locale: locale) if parts.empty?

      sentencify(parts, scope, locale)
    end

    private

    def parse_options(options)
      format = normalize_format(options.fetch(:format, :compact))
      locale = options.fetch(:locale, I18n.locale)

      scope = format == :full ? I18N_SCOPE_FULL : DEFAULT_I18N_SCOPE

      [locale, scope]
    end

    def normalize_format(format)
      symbol = format.respond_to?(:to_sym) ? format.to_sym : format

      return symbol if VALID_FORMATS.include?(symbol)

      raise ArgumentError,
            "invalid :format, #{format.inspect} given. Valid formats: #{VALID_FORMATS.map(&:inspect).join(', ')}"
    end

    def sentencify(parts, scope, locale)
      parts
        .sort_by { |unit, _| ActiveSupport::Duration::PARTS.index(unit) }
        .map     { |unit, val| I18n.t(unit, count: val, scope: scope, locale: locale) }
        .to_sentence(sentence_options(scope, locale))
    end

    def sentence_options(scope, locale)
      I18n.t(:support, scope: scope, locale: locale, default: { locale: locale })
    end

    def raise_type_error(type)
      raise TypeError, "no implicit conversion of #{type.class} into ActiveSupport::Duration"
    end
  end
end
