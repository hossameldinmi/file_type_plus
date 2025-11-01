# file-type

[![Test Coverage](https://github.com/hossameldinmi/file-type/actions/workflows/coverage.yml/badge.svg)](https://github.com/hossameldinmi/file-type/actions/workflows/coverage.yml)

A Dart package that detects the file type from mime type, file extension, or file bytes.

## Features

- Detect file types from file extensions
- Detect file types from MIME types
- Detect file types from file bytes (magic numbers)
- Detect file types from file paths
- Support for multiple file categories: image, audio, video, document, html, archive, and other
- 100% test coverage

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  file_type_plus: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Usage

```dart
import 'package:file_type_plus/file_type_plus.dart';

// Detect from file extension
final type = FileType.fromExtensionOrMime(extension: 'jpg');
print(type.value); // image

// Detect from MIME type
final type = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
print(type.value); // image

// Detect from file path
final type = FileType.fromPath('photo.jpg', null);
print(type.value); // image

// Detect from bytes
final bytes = Uint8List.fromList([0xFF, 0xD8, 0xFF]);
final type = FileType.fromBytes(bytes, null);
print(type.value); // image
```

### Filtering Files

```dart
final files = ['photo.jpg', 'song.mp3', 'video.mp4'];

// Filter by single type
final images = files.where((f) => 
  FileType.fromPath(f, null) == FileType.image
).toList();

// Filter by multiple types
final media = files.where((f) {
  final type = FileType.fromPath(f, null);
  return type.isAny([FileType.image, FileType.audio, FileType.video]);
}).toList();
```

## Examples

Check out the [example](example/) directory for comprehensive examples:

- **[basic_usage.dart](example/basic_usage.dart)** - Basic file type detection
- **[path_detection.dart](example/path_detection.dart)** - Detecting from file paths and URLs
- **[bytes_detection.dart](example/bytes_detection.dart)** - Detecting from byte data
- **[filtering_files.dart](example/filtering_files.dart)** - Filtering and categorizing files
- **[html_filtering.dart](example/html_filtering.dart)** - HTML file detection
- **[advanced_usage.dart](example/advanced_usage.dart)** - Advanced use cases

Run any example:

```bash
dart run example/basic_usage.dart
```

## Available File Types

- `FileType.image` - Image files (jpg, png, gif, etc.)
- `FileType.audio` - Audio files (mp3, wav, flac, etc.)
- `FileType.video` - Video files (mp4, avi, mov, etc.)
- `FileType.document` - Document files (pdf, doc, txt, etc.)
- `FileType.html` - HTML files (html, htm, xhtml, etc.)
- `FileType.archive` - Archive files (zip, rar, tar, etc.)
- `FileType.other` - Unknown or unclassified files

## Development

### Running Tests

```bash
dart test
```

### Running Tests with Coverage

```bash
# Quick way
dart test --coverage=coverage
