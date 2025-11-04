// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type_plus/file_type_plus.dart';

/// Examples demonstrating FileType constructor usage.
///
/// This file shows how to use the FileType constructor directly with
/// ExtensionGroupFilter to create FileType instances or extend the FileType class.
void main() {
  print('=== FileType Constructor Examples ===\n');

  // Example 1: Creating FileType instances directly
  print('1. Direct instantiation using ExtensionGroupFilter:\n');

  final imageType = FileType(ExtensionGroupFilter.image);
  print('Created image type: ${imageType.value}');
  print('Number of image extensions: ${imageType.extensionMap.length}');

  final audioType = FileType(ExtensionGroupFilter.audio);
  print('Created audio type: ${audioType.value}');
  print('Number of audio extensions: ${audioType.extensionMap.length}');

  final videoType = FileType(ExtensionGroupFilter.video);
  print('Created video type: ${videoType.value}');
  print('Number of video extensions: ${videoType.extensionMap.length}');

  // Example 2: Using the constructor in a custom class
  print('\n2. Extending FileType with custom properties:\n');

  final customImage = CustomFileType(
    ExtensionGroupFilter.image,
    metadata: {
      'maxSize': '10MB',
      'allowedFormats': ['jpg', 'png', 'webp']
    },
  );
  print('Custom image type: ${customImage.value}');
  print('Custom metadata: ${customImage.metadata}');

  final customVideo = CustomFileType(
    ExtensionGroupFilter.video,
    metadata: {'maxDuration': '3600s', 'codec': 'H.264'},
  );
  print('Custom video type: ${customVideo.value}');
  print('Custom metadata: ${customVideo.metadata}');

  // Example 3: Creating specialized file type classes
  print('\n3. Specialized file type classes:\n');

  final restrictedImage = RestrictedMediaType(
    ExtensionGroupFilter.image,
    allowedExtensions: {'jpg', 'png', 'gif'},
  );
  print('Restricted image type: ${restrictedImage.value}');
  print('Is jpg allowed? ${restrictedImage.isExtensionAllowed('jpg')}');
  print('Is webp allowed? ${restrictedImage.isExtensionAllowed('webp')}');

  final restrictedVideo = RestrictedMediaType(
    ExtensionGroupFilter.video,
    allowedExtensions: {'mp4', 'webm'},
  );
  print('Restricted video type: ${restrictedVideo.value}');
  print('Is mp4 allowed? ${restrictedVideo.isExtensionAllowed('mp4')}');
  print('Is avi allowed? ${restrictedVideo.isExtensionAllowed('avi')}');

  // Example 4: Comparison with static constants
  print('\n4. Constructor vs static constants:\n');

  final constructedImage = FileType(ExtensionGroupFilter.image);
  final staticImage = FileType.image;

  print('Are they equal? ${constructedImage == staticImage}'); // true
  print('Same value? ${constructedImage.value == staticImage.value}'); // true
  print('Same extension count? ${constructedImage.extensionMap.length == staticImage.extensionMap.length}'); // true

  // Example 5: Iterating through all filter types
  print('\n5. Creating FileType instances for all categories:\n');

  final allFilters = [
    ExtensionGroupFilter.image,
    ExtensionGroupFilter.audio,
    ExtensionGroupFilter.video,
    ExtensionGroupFilter.document,
    ExtensionGroupFilter.html,
    ExtensionGroupFilter.archive,
    ExtensionGroupFilter.other,
  ];

  for (final filter in allFilters) {
    final fileType = FileType(filter);
    print('${fileType.value}: ${fileType.extensionMap.length} extensions');
  }

  // Example 6: Using constructor for validation
  print('\n6. Validation with custom file type:\n');

  final validator = FileTypeValidator(
    ExtensionGroupFilter.image,
    maxSize: 1024 * 1024 * 5, // 5MB
  );
  print('Validator for: ${validator.value}');
  print('Max size: ${validator.maxSize} bytes');
  print('Can validate 3MB file? ${validator.validateSize(3 * 1024 * 1024)}');
  print('Can validate 10MB file? ${validator.validateSize(10 * 1024 * 1024)}');
}

/// Example 1: Custom FileType with metadata
///
/// Demonstrates extending FileType to add custom properties while
/// maintaining all the base functionality.
class CustomFileType extends FileType {
  /// Additional metadata associated with this file type
  final Map<String, dynamic> metadata;

  /// Creates a custom file type with metadata
  ///
  /// [filter] - The extension group filter defining the category
  /// [metadata] - Custom metadata to attach to this file type
  CustomFileType(ExtensionGroupFilter filter, {required this.metadata}) : super(filter);

  @override
  String toString() => 'CustomFileType($value, metadata: $metadata)';
}

/// Example 2: Restricted media type with allowed extensions
///
/// Demonstrates creating a specialized file type that only allows
/// specific extensions from a broader category.
class RestrictedMediaType extends FileType {
  /// Set of allowed file extensions (without dots)
  final Set<String> allowedExtensions;

  /// Creates a restricted media type
  ///
  /// [filter] - The base extension group filter
  /// [allowedExtensions] - Set of extensions to allow from the category
  RestrictedMediaType(
    ExtensionGroupFilter filter, {
    required this.allowedExtensions,
  }) : super(filter);

  /// Checks if a specific extension is allowed
  bool isExtensionAllowed(String extension) {
    return allowedExtensions.contains(extension.toLowerCase());
  }

  /// Gets only the allowed extensions from the full extension map
  Map<String, String> get allowedExtensionMap {
    return Map.fromEntries(
      extensionMap.entries.where(
        (entry) => allowedExtensions.contains(entry.key),
      ),
    );
  }

  @override
  String toString() => 'RestrictedMediaType($value, allowed: ${allowedExtensions.length}/${extensionMap.length})';
}

/// Example 3: File type validator with size constraints
///
/// Demonstrates creating a file type with validation logic.
class FileTypeValidator extends FileType {
  /// Maximum allowed file size in bytes
  final int maxSize;

  /// Creates a file type validator
  ///
  /// [filter] - The extension group filter
  /// [maxSize] - Maximum file size in bytes
  FileTypeValidator(ExtensionGroupFilter filter, {required this.maxSize}) : super(filter);

  /// Validates if a file size is within the allowed limit
  bool validateSize(int sizeInBytes) {
    return sizeInBytes <= maxSize;
  }

  /// Gets the max size in a human-readable format
  String get maxSizeFormatted {
    if (maxSize >= 1024 * 1024) {
      return '${(maxSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else if (maxSize >= 1024) {
      return '${(maxSize / 1024).toStringAsFixed(2)} KB';
    } else {
      return '$maxSize bytes';
    }
  }

  @override
  String toString() => 'FileTypeValidator($value, maxSize: $maxSizeFormatted)';
}
