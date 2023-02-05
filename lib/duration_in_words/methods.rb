# frozen_string_literal: true

module DurationInWords
  module Methods
    extend self

    def duration_in_words(duration, options = {})
      raise_type_error(duration) unless duration.is_a?(ActiveSupport::Duration)

      format, locale, unit_connector = parse_options(options)
      scope = format.to_s == "full" ? I18N_SCOPE_FULL : DEFAULT_I18N_SCOPE

      units = load_units(scope, locale)
      parts = duration.parts

      if parts.empty?
        return "#{duration.value} #{duration.value == 1 ? units[:seconds][:one] : units[:seconds][:other]}"
      end

      parts
        .sort_by { |unit, _| ActiveSupport::Duration::PARTS.index(unit) }
        .map     { |unit, val| "#{val}#{unit_connector}#{val == 1 ? units[unit][:one] : units[unit][:other]}" }
        .to_sentence(locale: locale)
    end

    private

    def parse_options(options = {})
      format = options.fetch(:format, :compact)
      locale = options.fetch(:locale, :en)
      unit_connector = options.fetch(:unit_connector, format == :compact ? "" : " ")

      [format, locale, unit_connector]
    end

    def load_units(scope, locale)
      translations = I18n.t(scope, locale: locale, default: {})
    end

    def raise_type_error(type)
      raise TypeError, "no implicit conversion of #{type.class} into ActiveSupport::Duration"
    end
  end
end
