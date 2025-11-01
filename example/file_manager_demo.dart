// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type_plus/file_type_plus.dart';

/// Complete example demonstrating a file manager application.
void main() {
  final fileManager = FileManager();

  print('=== File Manager Demo ===\n');

  // Add various files
  fileManager
    ..addFile('Documents/report.pdf')
    ..addFile('Documents/presentation.pptx')
    ..addFile('Documents/notes.txt')
    ..addFile('Photos/vacation.jpg')
    ..addFile('Photos/family.png')
    ..addFile('Photos/screenshot.bmp')
    ..addFile('Music/song1.mp3')
    ..addFile('Music/album.flac')
    ..addFile('Music/podcast.m4a')
    ..addFile('Videos/movie.mp4')
    ..addFile('Videos/clip.avi')
    ..addFile('Videos/recording.mov')
    ..addFile('Downloads/archive.zip')
    ..addFile('Downloads/installer.exe')
    ..addFile('Web/index.html')
    ..addFile('Web/style.css')
    ..addFile('Web/app.js');

  // Display statistics
  fileManager.printStatistics();

  // Search for files
  print('\n=== Search Results ===\n');
  print('Images:');
  fileManager.searchByType(FileType.image).forEach((f) => print('  📷 $f'));

  print('\nDocuments:');
  fileManager.searchByType(FileType.document).forEach((f) => print('  📄 $f'));

  print('\nMedia files (images, audio, video):');
  fileManager.searchByTypes([FileType.image, FileType.audio, FileType.video]).forEach((f) => print('  🎬 $f'));

  // Get files by folder
  print('\n=== Files by Folder ===\n');
  fileManager.printFilesByFolder();

  // Storage analysis
  print('\n=== Storage Analysis ===\n');
  fileManager.printStorageAnalysis();

  // Export capabilities
  print('\n=== Export Options ===\n');
  fileManager.printExportOptions();
}

class FileManager {
  final List<String> _files = [];

  void addFile(String path) {
    _files.add(path);
  }

  List<String> searchByType(FileType type) => _files.where((file) {
        final fileType = FileType.fromPath(file);
        return fileType == type;
      }).toList();

  List<String> searchByTypes(List<FileType> types) => _files.where((file) {
        final fileType = FileType.fromPath(file);
        return fileType.isAny(types);
      }).toList();

  Map<String, List<String>> groupByType() {
    final grouped = <String, List<String>>{};
    for (final file in _files) {
      final type = FileType.fromPath(file).value;
      grouped.putIfAbsent(type, () => []).add(file);
    }
    return grouped;
  }

  Map<String, List<String>> groupByFolder() {
    final grouped = <String, List<String>>{};
    for (final file in _files) {
      final folder = file.contains('/') ? file.split('/').first : 'Root';
      grouped.putIfAbsent(folder, () => []).add(file);
    }
    return grouped;
  }

  void printStatistics() {
    print('Total files: ${_files.length}');
    print('\nBreakdown by type:');

    final grouped = groupByType();
    grouped.forEach((type, files) {
      final percentage = (files.length / _files.length * 100).toStringAsFixed(1);
      print('  $type: ${files.length} files ($percentage%)');
    });
  }

  void printFilesByFolder() {
    final byFolder = groupByFolder();
    byFolder.forEach((folder, files) {
      print('$folder/ (${files.length} files)');
      for (final file in files) {
        final type = FileType.fromPath(file);
        final icon = _getIcon(type);
        final filename = file.split('/').last;
        print('  $icon $filename');
      }
      print('');
    });
  }

  void printStorageAnalysis() {
    // Simulated storage usage (in real app, would use actual file sizes)
    final mediaFiles = searchByTypes([FileType.image, FileType.audio, FileType.video]);
    final documentFiles = searchByType(FileType.document);
    final archiveFiles = searchByType(FileType.archive);

    print('Media files: ${mediaFiles.length}');
    print('Documents: ${documentFiles.length}');
    print('Archives: ${archiveFiles.length}');
    print('Other: ${_files.length - mediaFiles.length - documentFiles.length - archiveFiles.length}');

    final mediaPercentage = (mediaFiles.length / _files.length * 100).toStringAsFixed(1);
    print('\nMedia files occupy $mediaPercentage% of total files');
  }

  void printExportOptions() {
    final exportable = searchByTypes([
      FileType.document,
      FileType.image,
    ]);

    print('Exportable files (documents & images): ${exportable.length}');
    print('\nFiles ready for export:');
    for (final file in exportable.take(5)) {
      final type = FileType.fromPath(file);
      print('  ✓ $file (${type.value})');
    }
    if (exportable.length > 5) {
      print('  ... and ${exportable.length - 5} more');
    }
  }

  String _getIcon(FileType type) {
    if (type == FileType.image) return '🖼️';
    if (type == FileType.audio) return '🎵';
    if (type == FileType.video) return '🎬';
    if (type == FileType.document) return '📄';
    if (type == FileType.html) return '🌐';
    if (type == FileType.archive) return '📦';
    return '📎';
  }
}
