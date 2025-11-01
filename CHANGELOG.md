# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-11-01

### Added
- Initial release of the file_type_plus package
- Core `FileType` class with support for 7 file type categories:
  - Image files (jpg, png, gif, bmp, svg, webp, etc.)
  - Audio files (mp3, wav, flac, aac, ogg, etc.)
  - Video files (mp4, avi, mov, webm, mkv, etc.)
  - Document files (pdf, doc, docx, xls, xlsx, ppt, pptx, etc.)
  - HTML files (html, htm, xhtml)
  - Archive files (zip, rar, tar, gz, 7z, etc.)
  - Other (fallback category)
- Multiple detection methods:
  - `FileType.fromExtensionOrMime()` - Detect from file extension or MIME type
  - `FileType.fromPath()` - Detect from file path or URL
  - `FileType.fromBytes()` - Detect from byte data using magic numbers
- Special support for streaming video formats:
  - ISM (IIS Smooth Streaming Manifest) detection
  - HLS (.m3u8) support
  - DASH (.mpd) support
- Utility methods:
  - `isAny()` - Check if file type matches any in a list
  - `isAnyType()` - Type checking utility
  - `extensionMap` - Access extension mappings for each type
- Comprehensive test suite with 81 tests and 100% line coverage
- Example files demonstrating various use cases:
  - `quick_start.dart` - Quick introduction
  - `basic_usage.dart` - Basic detection examples
  - `path_detection.dart` - Path and URL detection
  - `bytes_detection.dart` - Magic number detection
  - `filtering_files.dart` - File filtering and categorization
  - `html_filtering.dart` - HTML file detection
  - `advanced_usage.dart` - Advanced usage patterns
  - `file_manager_demo.dart` - Complete file manager application
- Code coverage infrastructure:
  - Coverage script (`tool/coverage.sh`)
  - GitHub Actions CI/CD workflow
  - Coverage reporting

### Fixed
- Null safety handling in `FileType.fromPath()` and `FileType.fromBytes()`
- HTML file detection to properly recognize HTML files (text/html, application/xhtml)
- Linting compliance with `dart_flutter_team_lints` rules

### Documentation
- Comprehensive README with installation and usage examples
- Detailed example documentation in `example/README.md`
- API documentation with doc comments
- Coverage badge in README

### Dependencies
- `equatable: ^2.0.7` - Value equality for FileType instances
- `mime: ^2.0.0` - MIME type detection and lookups

### Development
- `dart_flutter_team_lints: ^3.0.0` - Linting rules
- `test: ^1.16.0` - Testing framework
- Dart SDK: >=3.2.0 <4.0.0

## [Unreleased]

### Planned
- Additional file type categories (fonts, code files, etc.)
- More magic number signatures for byte detection
- Performance optimizations
- Additional MIME type mappings

[0.1.0]: https://github.com/hossameldinmi/file-type/releases/tag/v0.1.0
