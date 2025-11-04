# Examples

This directory contains comprehensive examples demonstrating various features of the `file_type_plus` package.

## Quick Start

New to the package? Start here:

```bash
dart run example/quick_start.dart
```

This shows the most common use cases in a simple format.

## Running Examples

To run any example:

```bash
dart run example/quick_start.dart      # 👈 Start here!
dart run example/basic_usage.dart
dart run example/constructor_usage.dart
dart run example/path_detection.dart
dart run example/bytes_detection.dart
dart run example/deserialization.dart
dart run example/filtering_files.dart
dart run example/html_filtering.dart
dart run example/advanced_usage.dart
dart run example/file_manager_demo.dart
```

## Example Files

### 0. `quick_start.dart` 👈 **Start Here!**
Quick introduction showing the most common use cases.

**Topics covered:**
- Basic detection from extension
- Basic detection from MIME type
- Detection from path
- Simple file filtering
- Multiple type filtering
- List of all available types

**Run:**
```bash
dart run example/quick_start.dart
```

### 1. `basic_usage.dart`
Basic file type detection using extensions and MIME types.

**Topics covered:**
- Detecting file types from extensions
- Detecting from MIME types
- Case-insensitive detection
- Extension vs MIME type priority
- Handling unknown types
- Listing all available types

**Run:**
```bash
dart run example/basic_usage.dart
```

### 2. `constructor_usage.dart`
Using the FileType constructor directly with ExtensionGroupFilter.

**Topics covered:**
- Direct instantiation with ExtensionGroupFilter
- Extending FileType with custom properties
- Creating specialized file type classes
- Adding metadata to file types
- Restricted media types with allowed extensions
- File type validators with size constraints
- Comparison with static constants
- Creating instances for all categories

**Run:**
```bash
dart run example/constructor_usage.dart
```

### 3. `path_detection.dart`
Detecting file types from file paths and URLs.

**Topics covered:**
- Simple file paths
- HTTP/HTTPS URLs
- Special case: ISM streaming detection
- Using explicit MIME types
- Complex paths with query parameters
- Windows paths
- File filtering by path
- Real-world media gallery example

**Run:**
```bash
dart run example/path_detection.dart
```

### 4. `bytes_detection.dart`
Detecting file types from byte data (magic numbers).

**Topics covered:**
- JPEG magic bytes detection
- PNG magic bytes detection
- PDF magic bytes detection
- MIME type override
- Unknown byte patterns
- Reading real files
- File upload validation
- Extension vs content validation

**Run:**
```bash
dart run example/bytes_detection.dart
```

### 5. `deserialization.dart`
Using `FileType.fromName()` for JSON and database deserialization.

**Topics covered:**
- JSON deserialization
- Multiple files from JSON
- Database record simulation
- Configuration files
- API response processing
- Handling unknown types
- Custom class with FileType
- Filtering deserialized data

**Run:**
```bash
dart run example/deserialization.dart
```

### 6. `filtering_files.dart`
Filtering and categorizing files by type.

**Topics covered:**
- Filter by single type
- Filter by multiple types using `isAny()`
- Grouping files by type
- File statistics
- Media gallery example
- Advanced filtering
- Excluding certain types

**Run:**
```bash
dart run example/filtering_files.dart
```

### 7. `html_filtering.dart`
Detecting and filtering HTML files.

**Topics covered:**
- HTML file extension detection
- MIME type detection
- Filtering HTML files from mixed content
- Web-related file filtering
- HTML extensions list
- Web project file processing
- Building site maps

**Run:**
```bash
dart run example/html_filtering.dart
```

### 8. `advanced_usage.dart`
Advanced use cases and patterns.

**Topics covered:**
- Extension map exploration
- Type comparison
- Using `isAnyType()`
- Streaming video detection (ISM, HLS)
- Building a file manager
- Content-Type headers
- Bulk file validation
- Custom icons by file type

**Run:**
```bash
dart run example/advanced_usage.dart
```

### 9. `file_manager_demo.dart`
Complete file manager application demonstration.

**Topics covered:**
- Building a complete file manager
- File organization by type
- File organization by folder
- Search functionality
- Storage analysis
- File statistics
- Export options
- Real-world application structure

**Run:**
```bash
dart run example/file_manager_demo.dart
```

## Quick Reference

### Basic Detection

```dart
// From extension
final type = FileType.fromExtensionOrMime(extension: 'jpg');
print(type.value); // image

// From MIME type
final type = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
print(type.value); // image

// From file path
final type = FileType.fromPath('photo.jpg', null);
print(type.value); // image

// From bytes
final bytes = Uint8List.fromList([0xFF, 0xD8, 0xFF]);
final type = FileType.fromBytes(bytes, null);
print(type.value); // image
```

### Filtering

```dart
// Single type
final images = files.where((f) => 
  FileType.fromPath(f, null) == FileType.image
).toList();

// Multiple types
final media = files.where((f) {
  final type = FileType.fromPath(f, null);
  return type.isAny([FileType.image, FileType.audio, FileType.video]);
}).toList();
```

### Available Types

- `FileType.image` - Image files (jpg, png, gif, etc.)
- `FileType.audio` - Audio files (mp3, wav, flac, etc.)
- `FileType.video` - Video files (mp4, avi, mov, etc.)
- `FileType.document` - Document files (pdf, doc, txt, etc.)
- `FileType.html` - HTML files (html, htm, xhtml, etc.)
- `FileType.archive` - Archive files (zip, rar, tar, etc.)
- `FileType.other` - Unknown or unclassified files

## See Also

- [Package Documentation](../README.md)
- [API Reference](https://pub.dev/documentation/file_type_plus/latest/)
- [Test Files](../test/) - Additional usage examples in tests
