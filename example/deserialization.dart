// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:file_type_plus/file_type_plus.dart';

/// Examples of using FileType.fromName() for deserialization scenarios.
void main() {
  print('=== JSON Deserialization ===\n');

  // Example 1: Simple JSON deserialization
  final jsonString = '{"name": "photo.jpg", "type": "image", "size": 1024}';
  final json = jsonDecode(jsonString) as Map<String, dynamic>;

  final fileType = FileType.fromName(json['type'] as String);
  print('File: ${json['name']}');
  print('Type from JSON: ${fileType.value}');
  print('Is image: ${fileType == FileType.image}');

  print('\n=== Multiple Files from JSON ===\n');

  // Example 2: List of files
  final filesJson = '''
  [
    {"name": "document.pdf", "type": "document"},
    {"name": "song.mp3", "type": "audio"},
    {"name": "movie.mp4", "type": "video"},
    {"name": "archive.zip", "type": "archive"}
  ]
  ''';

  final filesList = jsonDecode(filesJson) as List;
  for (final item in filesList) {
    final file = item as Map<String, dynamic>;
    final type = FileType.fromName(file['type'] as String);
    final icon = _getIcon(type);
    print('$icon ${file['name']} (${type.value})');
  }

  print('\n=== Database Record Simulation ===\n');

  // Example 3: Database-like records
  final dbRecords = [
    {'id': 1, 'filename': 'report.pdf', 'file_type': 'document', 'owner': 'Alice'},
    {'id': 2, 'filename': 'photo.jpg', 'file_type': 'image', 'owner': 'Bob'},
    {'id': 3, 'filename': 'backup.tar.gz', 'file_type': 'archive', 'owner': 'Charlie'},
  ];

  for (final record in dbRecords) {
    final type = FileType.fromName(record['file_type'] as String);
    print('ID ${record['id']}: ${record['filename']} (${type.value}) - Owner: ${record['owner']}');
  }

  print('\n=== Configuration File ===\n');

  // Example 4: Reading from configuration
  final config = {
    'allowed_upload_types': ['image', 'document', 'archive'],
    'max_file_size': 10485760,
  };

  print('Allowed upload types:');
  for (final typeName in config['allowed_upload_types'] as List) {
    final type = FileType.fromName(typeName as String);
    print('  - ${type.value} (${type.extensionMap.length} extensions)');
  }

  print('\n=== API Response ===\n');

  // Example 5: Processing API response
  final apiResponse = '''
  {
    "status": "success",
    "files": [
      {"path": "/uploads/image1.jpg", "category": "image", "uploaded_at": "2025-11-03"},
      {"path": "/uploads/video1.mp4", "category": "video", "uploaded_at": "2025-11-03"}
    ]
  }
  ''';

  final response = jsonDecode(apiResponse) as Map<String, dynamic>;
  final files = response['files'] as List;

  print('Uploaded files:');
  for (final file in files) {
    final fileMap = file as Map<String, dynamic>;
    final category = FileType.fromName(fileMap['category'] as String);
    print('  ${fileMap['path']} - ${category.value}');
  }

  print('\n=== Handling Unknown Types ===\n');

  // Example 6: Fallback for unknown types
  final mixedData = [
    {'name': 'file1.txt', 'type': 'document'},
    {'name': 'file2.xyz', 'type': 'unknown_type'},
    {'name': 'file3.jpg', 'type': 'image'},
  ];

  for (final item in mixedData) {
    final type = FileType.fromName(item['type'] as String);
    final status = type == FileType.other ? '⚠️  Unknown' : '✓ Known';
    print('$status: ${item['name']} -> ${type.value}');
  }

  print('\n=== File Metadata Class ===\n');

  // Example 7: Custom class with deserialization
  final metadataJson = '''
  {
    "name": "presentation.pptx",
    "type": "document",
    "size": 5242880,
    "created": "2025-11-03T10:30:00Z"
  }
  ''';

  final metadata = FileMetadata.fromJson(jsonDecode(metadataJson) as Map<String, dynamic>);
  print('File Metadata:');
  print('  Name: ${metadata.name}');
  print('  Type: ${metadata.fileType.value}');
  print('  Size: ${metadata.size} bytes');
  print('  Created: ${metadata.created}');

  print('\n=== Filtering by Type from JSON ===\n');

  // Example 8: Filter files by type
  final allFiles = [
    {'name': 'photo1.jpg', 'type': 'image'},
    {'name': 'photo2.png', 'type': 'image'},
    {'name': 'song.mp3', 'type': 'audio'},
    {'name': 'video.mp4', 'type': 'video'},
    {'name': 'doc.pdf', 'type': 'document'},
  ];

  final imageFiles = allFiles.where((file) {
    final type = FileType.fromName(file['type'] as String);
    return type == FileType.image;
  }).toList();

  print('Image files only:');
  for (final file in imageFiles) {
    print('  - ${file['name']}');
  }
}

/// Example class demonstrating deserialization with FileType
class FileMetadata {
  final String name;
  final FileType fileType;
  final int size;
  final String created;

  FileMetadata({
    required this.name,
    required this.fileType,
    required this.size,
    required this.created,
  });

  factory FileMetadata.fromJson(Map<String, dynamic> json) {
    return FileMetadata(
      name: json['name'] as String,
      fileType: FileType.fromName(json['type'] as String),
      size: json['size'] as int,
      created: json['created'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': fileType.value,
      'size': size,
      'created': created,
    };
  }
}

String _getIcon(FileType type) {
  if (type == FileType.image) return '🖼️ ';
  if (type == FileType.audio) return '🎵';
  if (type == FileType.video) return '🎬';
  if (type == FileType.document) return '📄';
  if (type == FileType.html) return '🌐';
  if (type == FileType.archive) return '📦';
  return '📁';
}
