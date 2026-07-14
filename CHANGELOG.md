## [0.4.0] - 2026-07-14

### Fixed

- Stop calling `I18n.reload!` when setting up locale files. It was discarding
  any translations the host app had already stored in memory (e.g. via
  `I18n.backend.store_translations`), not just ones loaded from files.
- Removed trailing whitespace from the `de` locale file.

### Changed

- `duration_in_words` now raises `ArgumentError` for an unrecognized `:format`
  value instead of silently falling back to `:compact`.
- CI now runs the test suite against a matrix of supported Ruby versions
  (2.6, 3.1, 3.4) instead of a single pinned version, and runs RuboCop and
  `bundler-audit` as separate jobs.
- Expanded the RBS signatures beyond `VERSION` to cover
  `DurationInWords::Methods` and the `ActionView` helper.

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
