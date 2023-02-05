# frozen_string_literal: true

module ActionView
  module Helpers
    module DurationHelper
      # Reports the Duration object as seconds.
      #
      # === Options
      # * <tt>:format</tt> - The format to be used in reporting the duration, :full or :compact (default: :compact)
      # * <tt>:locale</tt> - If +I18n+ is available, you can set a locale and use the connector options defined on
      #   the 'support.array' namespace in the corresponding dictionary file.
      #
      # === Examples
      # d = 1.day + 2.hours + 30.minutes
      # duration_in_words(d)                  => 1d, 2h, and 30m
      # d = 2.hours
      # duration_in_words(d)                  => 2h
      #
      # Using <tt>:format</tt> option:
      # d = 1.day + 2.hours + 30.minutes
      # duration_in_words(d, format: :full)   => 1 day, 2 hours, and 30 minutes
      #
      # Using <tt>:locale</tt> option:
      #   # Given this locale dictionary:
      #   #
      #   # de:
      #   #   support:
      #   #     array:
      #   #       words_connector: ', '
      #   #       two_words_connector: ' und '
      #   #       last_word_connector: ', und '
      #   #   duration:
      #   #     in_words:
      #   #       full:
      #   #         years:
      #   #           one: Jahr
      #   #           other: Jahre
      #   #         months:
      #   #           one: Monat
      #   #           other: Monate
      #   #         days:
      #   #           one: Tag
      #   #           other: Tage
      #   #         hours:
      #   #           one: Stunde
      #   #           other: Std.
      #   #         minutes:
      #   #           one: Minute
      #   #           other: Minuten
      #   #         seconds:
      #   #           one: Sekunde
      #   #           other: Sekunden
      #
      # d = 1.day + 2.hours + 30.minutes
      # duration_in_words(d, locale: :de)     => 1 Tag 2 Std., und 30 Sekunden
      #
      def duration_in_words(duration, options = {})
        raise_type_error(duration) unless ActiveSupport::Duration === duration

        format    = options.fetch(:format, :compact)
        locale    = options.fetch(:locale, :en)
        scope     = 'full' == format.to_s ? I18N_SCOPE_FULL : I18N_SCOPE_COMPACT

        defaults  = I18n.t(scope, locale: :en) # Default translations as fallback
        units     = I18n.t(scope, locale: locale, default: defaults)
        value     = duration.value
        parts     = duration.parts

        return "#{value} #{value == 1 ? units[:seconds][:one] : units[:seconds][:other]}" if parts.empty?

        unit_connector = options.fetch(:unit_connector, format == :compact ? '' : ' ')
        parts.
          sort_by { |unit, _| ActiveSupport::Duration::PARTS.index(unit) }.
          map     { |unit, val| "#{val}#{unit_connector}#{val == 1 ? units[unit][:one] : units[unit][:other]}" }.
          to_sentence(locale: locale)
      end

      private

      def raise_type_error(type)
        raise TypeError, "no implicit conversion of #{type.class} into ActiveSupport::Duration"
      end
    end
  end
end
