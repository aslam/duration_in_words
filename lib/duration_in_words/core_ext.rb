# frozen_string_literal: true

require "duration_in_words"

module ActiveSupport
  class Duration
    def in_words(options = {})
      DurationInWords::Methods.duration_in_words(self, options)
    end
  end
end
