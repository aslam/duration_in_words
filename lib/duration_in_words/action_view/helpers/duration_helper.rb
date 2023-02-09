# frozen_string_literal: true

module ActionView
  module Helpers
    module DurationHelper
      include DurationInWords::Methods

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
      #   #   duration:
      #   #     in_words:
      #   #       format:
      #   #         compact:
      #   #           support:
      #   #             words_connector: ', '
      #   #             two_words_connector: ' und '
      #   #             last_word_connector: ', und '
      #   #           years:
      #   #             one: J
      #   #             other: ...
      #   #           months:
      #   #             ...
      #   #         full:
      #   #           ...
      #
      # d = 1.day + 2.hours + 30.minutes
      # duration_in_words(d, locale: :de)     => 1 Tag, 2 Std., und 30 Sekunden
      #
      def duration_in_words(duration, options = {})
        DurationInWords::Methods.duration_in_words(duration, options)
      end
    end
  end
end
