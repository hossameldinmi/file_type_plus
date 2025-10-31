// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type/file_type.dart';

/// Examples of HTML file detection and filtering.
void main() {
  print('=== HTML File Detection Examples ===\n');

  // Detect from file extension
  final htmlFile = FileType.fromPath('index.html');
  print('index.html -> ${htmlFile.value}'); // html

  final htmFile = FileType.fromPath('page.htm');
  print('page.htm -> ${htmFile.value}'); // html

  final xhtmlFile = FileType.fromPath('document.xhtml');
  print('document.xhtml -> ${xhtmlFile.value}'); // html

  print('\n=== Using MIME Types ===\n');

  // Detect from MIME type
  final htmlMime = FileType.fromExtensionOrMime(mimeType: 'text/html');
  print('text/html -> ${htmlMime.value}'); // html

  final xhtmlMime = FileType.fromExtensionOrMime(mimeType: 'application/xhtml+xml');
  print('application/xhtml+xml -> ${xhtmlMime.value}'); // html

  print('\n=== Filtering Files ===\n');

  // Check if a file is HTML
  final files = [
    'index.html',
    'style.css',
    'script.js',
    'image.jpg',
    'document.pdf',
    'page.htm',
    'app.xhtml',
  ];

  final htmlFiles = files.where((file) {
    final fileType = FileType.fromPath(file);
    return fileType == FileType.html;
  }).toList();

  print('HTML files: $htmlFiles');

  print('\n=== Using isAny for Multiple Types ===\n');

  // Filter for web-related files (HTML and images)
  final webFiles = files.where((file) {
    final fileType = FileType.fromPath(file);
    return fileType.isAny([FileType.html, FileType.image]);
  }).toList();

  print('Web files (HTML + Images): $webFiles');

  print('\n=== Checking File Extensions in HTML Category ===\n');

  // Get all HTML-related extensions
  final htmlExtensions = FileType.html.extensionMap.keys.toList();
  print('HTML extensions: $htmlExtensions');

  print('\n=== Complete Example: Processing HTML Files ===\n');

  final testFiles = {
    'index.html': 'text/html',
    'app.xhtml': 'application/xhtml+xml',
    'document.pdf': 'application/pdf',
    'image.png': 'image/png',
    'data.json': 'application/json',
    'page.htm': 'text/html',
  };

  testFiles.forEach((filename, mimeType) {
    final fileType = FileType.fromPath(filename, mimeType);
    final isHtml = fileType == FileType.html;
    final icon = isHtml ? '🌐' : '📄';
    print('$icon $filename ($mimeType) -> ${fileType.value}');
  });

  print('\n=== Real-World Example: Web Project Files ===\n');

  final projectFiles = [
    'src/index.html',
    'src/about.html',
    'src/contact.htm',
    'public/app.xhtml',
    'assets/style.css',
    'assets/script.js',
    'assets/logo.png',
    'assets/icon.svg',
    'docs/readme.md',
    'build/bundle.js',
  ];

  print('HTML pages in project:');
  final htmlPages = projectFiles.where((f) => FileType.fromPath(f) == FileType.html).toList();

  for (final page in htmlPages) {
    print('  📄 $page');
  }
  print('\nTotal HTML pages: ${htmlPages.length}');

  print('\n=== Building a Site Map ===\n');

  final sitePages = [
    '/index.html',
    '/about.html',
    '/services.html',
    '/contact.htm',
    '/blog/post1.html',
    '/blog/post2.html',
    '/api/data.json',
    '/assets/image.jpg',
  ];

  print('Site map (HTML pages only):');
  sitePages.where((path) {
    final filename = path.split('/').last;
    return FileType.fromPath(filename) == FileType.html;
  }).forEach((path) {
    final indent = '  ' * (path.split('/').length - 2);
    final page = path.split('/').last;
    print('$indent- $page');
  });
}
