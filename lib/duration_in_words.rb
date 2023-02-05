# frozen_string_literal: true

require "i18n"
require "active_support"
require "active_support/core_ext"

require_relative "duration_in_words/version"

module DurationInWords
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Methods, "duration_in_words/methods"
  end

  I18N_SCOPE_FULL = :'duration.in_words.format.full'
  DEFAULT_I18N_SCOPE = :'duration.in_words.format.compact'

  module_function

  def setup_i18n!
    locale_files = Dir[File.join File.dirname(__FILE__), "duration_in_words/locales", "*.yml"]

    I18n.load_path.unshift(*locale_files)
    I18n.reload!
  end
end

DurationInWords.setup_i18n!

begin
  require "action_view"
  require_relative "duration_in_words/action_view/helpers/duration_helper"
rescue LoadError
end
