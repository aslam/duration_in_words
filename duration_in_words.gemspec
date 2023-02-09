# frozen_string_literal: true

require_relative "lib/duration_in_words/version"

Gem::Specification.new do |spec|
  spec.name = "duration_in_words"
  spec.version = DurationInWords::VERSION
  spec.authors = ["Syed Aslam"]
  spec.email = ["aslam.maqsood@gmail.com"]

  spec.summary = "Report ActiveSupport::Duration in concise human readable formats."
  spec.description = "Convert ActiveSupport::Duration objects to concise human readable formats like '2h 30m 45s'
    with locale support."
  spec.homepage = "https://github.com/aslam/duration_in_words"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/aslam/duration_in_words/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 5.1"
  spec.add_dependency "i18n"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "rubocop-rspec", "~> 2.18.1"
end
