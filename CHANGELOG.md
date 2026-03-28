## [Unreleased]

## [0.3.1] - 2026-03-28

### Fixed

- Respect the current `I18n.locale` by default when formatting durations.
- Delegate pluralization to I18n so locales with plural forms beyond `one` and `other` are handled correctly.

### Changed

- Modernized the RuboCop configuration for the current toolchain and added RubyGems MFA metadata.

## [0.3.0] - 2025-08-20

### Added

- Support for `weeks` as a duration unit by adding the necessary translations to the `en` and `de` locale files.

## [0.2.0] - 2023-02-04

### Added

- Support for `:full` format for more descriptive output (e.g., "1 day, 2 hours, and 30 minutes").
- Internationalization (i18n) support using the `:locale` option.
- Handling of fractional duration values (e.g., `2.5.minutes`).

## [0.1.0] - 2023-02-04

- Initial release
