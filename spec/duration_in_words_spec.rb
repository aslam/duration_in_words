# frozen_string_literal: true

require "spec_helper"

RSpec.describe DurationInWords do
  if defined?(ActionView)
    include ActionView::Helpers::DurationHelper
  else
    include DurationInWords::Methods
  end

  before do
    I18n.locale = :en
  end

  it "has a version number" do
    expect(DurationInWords::VERSION).not_to be nil
  end

  it "raises an error when the argument is of not type ActiveSupport::Duration" do
    expect { duration_in_words(Time.now) }.to raise_error(TypeError)
  end

  it "uses the current I18n locale when one is not provided" do
    I18n.locale = :de

    expect(duration_in_words(1.hour)).to eq("1Std.")
  end

  describe "#duration_in_words" do
    [
      [30.seconds, "30s", "30 seconds"],
      [0.5.minutes, "0.5m", "0.5 minutes"],
      [2.5.minutes, "2.5m", "2.5 minutes"],
      [1.hour, "1h", "1 hour"],
      [2.hours + 15.minutes, "2h and 15m", "2 hours and 15 minutes"],
      [1.day + 2.hours + 30.minutes, "1d 2h and 30m", "1 day, 2 hours, and 30 minutes"],
      [1.year + 3.days + 4.hours + 20.minutes + 30.seconds, "1yr. 3d 4h 20m and 30s",
       "1 year, 3 days, 4 hours, 20 minutes, and 30 seconds"],
      [1.week, "1wk.", "1 week"],
      [3.weeks, "3wks.", "3 weeks"]
    ].each do |duration, compact_result, full_result|
      context "with a duration of #{duration}" do
        it "formats as '#{compact_result}' in compact mode" do
          expect(duration_in_words(duration)).to eq(compact_result)
        end

        it "formats as '#{full_result}' in full mode" do
          expect(duration_in_words(duration, format: :full)).to eq(full_result)
        end
      end
    end
  end

  context "with locale" do
    [
      [30.seconds, "30s", "30 Sekunden"],
      [0.5.minutes, "0.5Min", "0.5 Minuten"],
      [2.5.minutes, "2.5Min", "2.5 Minuten"],
      [1.hour, "1Std.", "1 Stunde"],
      [2.hours + 15.minutes, "2Std. und 15Min", "2 Stunden und 15 Minuten"],
      [1.day + 2.hours + 30.minutes, "1T 2Std. und 30Min", "1 Tag 2 Stunden und 30 Minuten"],
      [1.year + 3.days + 4.hours + 20.minutes + 30.seconds, "1J 3T 4Std. 20Min und 30s",
       "1 Jahr 3 Tage 4 Stunden 20 Minuten und 30 Sekunden"],
      [1.week, "1W", "1 Woche"],
      [3.weeks, "3W", "3 Wochen"]
    ].each do |duration, compact_result, full_result|
      context "with a duration of #{duration}" do
        it "formats as '#{compact_result}' in compact mode" do
          expect(duration_in_words(duration, locale: :de)).to eq(compact_result)
        end

        it "formats as '#{full_result}' in full mode" do
          expect(duration_in_words(duration, locale: :de, format: :full)).to eq(full_result)
        end
      end
    end
  end

  context "with a locale that uses additional plural forms" do
    before do
      require "i18n/backend/pluralization"

      I18n::Backend::Simple.include(I18n::Backend::Pluralization)
      I18n.backend.store_translations(
        :xx,
        i18n: {
          plural: {
            rule: lambda { |count|
              if count == 1
                :one
              elsif count == 2
                :few
              else
                :other
              end
            }
          }
        },
        duration: {
          in_words: {
            format: {
              compact: {
                hours: {
                  one: "%<count>s one",
                  few: "%<count>s few",
                  other: "%<count>s other"
                },
                support: {
                  words_connector: " ",
                  two_words_connector: " and ",
                  last_word_connector: " and "
                }
              }
            }
          }
        }
      )

      I18n.available_locales = %i[en de xx]
    end

    it "uses the :one plural form" do
      expect(duration_in_words(1.hour, locale: :xx)).to eq("1 one")
    end

    it "uses the custom :few plural form" do
      expect(duration_in_words(2.hours, locale: :xx)).to eq("2 few")
    end

    it "uses the :other plural form" do
      expect(duration_in_words(3.hours, locale: :xx)).to eq("3 other")
    end
  end
end
