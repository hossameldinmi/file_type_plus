<h2 align="center">
  File Type Plus
</h2>

<p align="center">
   <a href="https://github.com/hossameldinmi/file_type_plus/actions/workflows/dart.yml">
    <img src="https://github.com/hossameldinmi/file_type_plus/actions/workflows/dart.yml/badge.svg?branch=main" alt="Github action">
  </a>
  <a href="https://codecov.io/github/hossameldinmi/file_type_plus">
    <img src="https://codecov.io/github/hossameldinmi/file_type_plus/graph/badge.svg?token=JzTIIzoQOq" alt="Code Coverage">
  </a>
  <a href="https://pub.dev/packages/file_type_plus">
    <img alt="Pub Package" src="https://img.shields.io/pub/v/file_type_plus">
  </a>
   <a href="https://pub.dev/packages/file_type_plus">
    <img alt="Pub Points" src="https://img.shields.io/pub/points/file_type_plus">
  </a>
  <br/>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
  <img src="https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20Web-blue" alt="Platforms">
</p>

---

**File Type Plus** is a powerful and lightweight Dart package that intelligently detects and categorizes file types with multiple detection methods. Whether you're working with file paths, URLs, MIME types, or raw byte data, this package provides accurate file type classification for images, audio, video, documents, HTML files, archives, and more.

Perfect for file upload validation, content management systems, file browsers, media galleries, and any application that needs reliable file type detection. Built with 100% test coverage and full null safety support.

## ✨ Features

- 🎯 **Multiple Detection Methods** - Detect from file extensions, MIME types, file paths, URLs, or raw bytes
- 🔍 **Magic Number Support** - Identify files by analyzing their byte signatures (magic numbers)
- 📁 **7 File Categories** - Organized classification: image, audio, video, document, HTML, archive, and other
- 🎬 **Streaming Video Support** - Special handling for ISM, HLS (.m3u8), and DASH formats
- ⚡ **Fast & Lightweight** - Minimal dependencies with efficient detection algorithms
- 🛡️ **Type Safe** - Full null safety and strong typing support
- ✅ **100% Test Coverage** - Thoroughly tested with 81+ unit tests
- 📦 **Easy Integration** - Simple API with comprehensive examples
- 🌐 **URL & Path Support** - Works with local paths, network URLs, and various path formats

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  file_type_plus: ^1.0.1
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
final type = FileType.fromPath('photo.jpg');
print(type.value); // image

// Detect from bytes
final bytes = Uint8List.fromList([0xFF, 0xD8, 0xFF]);
final type = FileType.fromBytes(bytes);
print(type.value); // image
```

### Filtering Files

```dart
final files = ['photo.jpg', 'song.mp3', 'video.mp4'];

// Filter by single type
final images = files.where((f) => 
  FileType.fromPath(f) == FileType.image
).toList();

// Filter by multiple types
final media = files.where((f) {
  final type = FileType.fromPath(f);
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
