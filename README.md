# DurationInWords ![Ruby](https://github.com/aslam/duration_in_words/actions/workflows/badge.svg)

`duration_in_words` provides a view helper to convert [ActiveSupport::Duration](https://api.rubyonrails.org/classes/ActiveSupport/Duration.html) objects into concise string like `1h 20m and 30s`, with locale support.

## Why?

Currently, there is no direct way to format `ActiveSupport::Duration` objects in `Rails`. You'd have to resort to using the `#inspect`, which provides limited configuration options. Also, the locale support in the `#inspect` was removed around `Rails 5.1`.

You could do something like the following to format an `ActiveSupport::Duration` object by hand in a view helper:

```ruby
def duration_as_sentence(duration)
  parts = duration.parts
  units = [:days, :hours, :minutes]
  map   = {
    :days     => { :one => :d },
    :hours    => { :one => :h, :other => :hrs },
    :minutes  => { :one => :m, :other => :mins }
  }

  parts.
    sort_by { |unit, _| units.index(unit) }.
    map     { |unit, val| "#{val} #{val == 1 ? map[unit][:one].to_s : map[unit][:other].to_s}" }.
    to_sentence
end
```

This gem does something similar along with providing a flexible way of defining formats in locale files and giving you an option to switch between `:compact`, and `:full` formats.

## Installation

Add to your `Gemfile`:

```ruby
gem "duration_in_words"
```

Install the gem by running `bundle install`.

## Usage

```ruby
include ActionView::Helpers::DurationHelper

>> duration = 2.hours
>> duration_in_words(duration)
=> "2h"
>> duration = 1.day + 2.hours + 30.minutes
>> duration_in_words(duration)
=> "1d 2h and 30m"
```

### Using <tt>:format</tt> option:

There are two formats available, `:compact`, and `:full`. `:compact` being the default.

```ruby
>> duration = 1.day + 2.hours + 30.minutes
>> duration_in_words(duration, format: :full)
=> "1 day 2 hours and 30 minutes"
```

### Using <tt>:locale</tt> option:

Given this locale dictionary:

```yaml
de:
  duration:
    in_words:
      format:
        compact:
          years:
            one: '%{count}J'
            other: '%{count}J'
          months:
            one: '%{count}M'
            other: '%{count}M'
          days:
            one: '%{count}T'
            other: '%{count}T'
          hours:
            one: '%{count}Std.'
            other: '%{count}Std.'
          minutes:
            one: '%{count}Min'
            other: '%{count}Min'
          seconds:
            one: '%{count}s'
            other: '%{count}s'
          support:
            words_connector: ' '
            two_words_connector: ' und '
            last_word_connector: ' und '
        full:
          years:
            one: '%{count} Jahr'
            other: '%{count} Jahre'
          months:
            one: '%{count} Monat'
            other: '%{count} Monate'
          days:
            one: '%{count} Tag'
            other: '%{count} Tage'
          hours:
            one: '%{count} Stunde'
            other: '%{count} Stunden'
          minutes:
            one: '%{count} Minute'
            other: '%{count} Minuten'
          seconds:
            one: '%{count} Sekunde'
            other: '%{count} Sekunden'
          support:
            words_connector: ', '
            two_words_connector: ' und '
            last_word_connector: ', und '
```

```ruby
>> duration = 1.day + 2.hours + 30.minutes
>> duration_in_words(duration, locale: :de)
=> "1T 2Std. und 30s"
>> duration_in_words(duration, format: :full, locale: :de)
>> "1 Tag, 2 Std., und 30 Sekunden"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aslam/duration_in_words.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
