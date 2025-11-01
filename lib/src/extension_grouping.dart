import 'package:mime/src/default_extension_map.dart' show defaultExtensionMap;

/// Groups file extensions by category (image, audio, video, etc.).
///
/// This class processes the default MIME type mappings and organizes them
/// into logical categories for easier file type detection and filtering.
class ExtensionsGrouping {
  /// A map of categorized file extensions.
  ///
  /// The outer map key is the category name (e.g., 'image', 'audio').
  /// The inner map contains extension-to-MIME-type mappings for that category.
  ///
  /// Example:
  /// ```dart
  /// {
  ///   'image': {'jpg': 'image/jpeg', 'png': 'image/png', ...},
  ///   'audio': {'mp3': 'audio/mpeg', 'wav': 'audio/wav', ...},
  /// }
  /// ```
  static final categorizedExtensions = _group(defaultExtensionMap);

  /// Groups extensions into categories based on their MIME types.
  ///
  /// Takes a map of file extensions to MIME types and categorizes them
  /// using the defined [_groups] filters. Each extension is placed in
  /// the first matching category.
  ///
  /// [extensionMap] - A map where keys are file extensions (without dots)
  /// and values are their corresponding MIME types.
  ///
  /// Returns a nested map structure with categories as keys and
  /// extension-MIME mappings as values.
  static Map<String, Map<String, String>> _group(Map<String, String> extensionMap) {
    final categorized = Map<String, Map<String, String>>.fromEntries(
      _groups.map((filter) => MapEntry(filter.name, <String, String>{})),
    );

    extensionMap.forEach((extension, mime) {
      for (var filter in _groups) {
        if (filter.test(extension, mime)) {
          categorized[filter.name]![extension] = mime;
          return;
        }
      }
    });

    return categorized;
  }

  /// Ordered list of category filters used for grouping extensions.
  ///
  /// The order matters: extensions are tested against each filter in sequence
  /// and placed in the first matching category. The 'other' filter must be
  /// last as it matches everything.
  static final Iterable<ExtensionGroupFilter> _groups = [
    ExtensionGroupFilter.image,
    ExtensionGroupFilter.audio,
    ExtensionGroupFilter.video,
    ExtensionGroupFilter.document,
    ExtensionGroupFilter.html,
    ExtensionGroupFilter.archive,

    /// Keep it last to catch all remaining extensions
    ExtensionGroupFilter.other,
  ];
}

/// A filter that categorizes file extensions based on custom logic.
///
/// Each filter has a name (category) and a test function that determines
/// whether a given extension and MIME type belong to that category.
class ExtensionGroupFilter {
  /// The name of this category (e.g., 'image', 'audio', 'video').
  final String name;

  /// A function that tests whether an extension and MIME type match this category.
  ///
  /// Parameters:
  /// - [extension] - The file extension without the dot (e.g., 'jpg', 'mp3')
  /// - [mime] - The MIME type string (e.g., 'image/jpeg', 'audio/mpeg')
  ///
  /// Returns `true` if the extension/MIME pair belongs to this category.
  final bool Function(String extension, String mime) test;

  /// Creates a new extension group filter.
  ///
  /// [name] - The category name for this filter.
  /// [test] - The function used to test if an extension belongs to this category.
  ExtensionGroupFilter(this.name, this.test);

  /// Filter for image files (jpg, png, gif, svg, webp, etc.).
  static final image = ExtensionGroupFilter('image', _isImage);

  /// Filter for audio files (mp3, wav, flac, aac, ogg, etc.).
  static final audio = ExtensionGroupFilter('audio', _isAudio);

  /// Filter for video files (mp4, avi, mov, webm, mkv, m3u8, etc.).
  static final video = ExtensionGroupFilter('video', _isVideo);

  /// Filter for document files (pdf, docx, xlsx, pptx, txt, epub, etc.).
  static final document = ExtensionGroupFilter('document', _isDocument);

  /// Filter for HTML files (html, htm, xhtml, xht).
  static final html = ExtensionGroupFilter('html', _isHtml);

  /// Filter for archive files (zip, rar, tar, gz, 7z, etc.).
  static final archive = ExtensionGroupFilter('archive', _isArchive);

  /// Catch-all filter that matches any remaining file type.
  ///
  /// This should always be the last filter in the list.
  static final other = ExtensionGroupFilter('other', (extension, mime) => true);

  /// Tests if the MIME type represents an image file.
  ///
  /// Matches any MIME type starting with 'image/' (e.g., image/jpeg, image/png).
  static bool _isImage(String extension, String mime) => mime.startsWith('image/');

  /// Tests if the MIME type represents an audio file.
  ///
  /// Matches any MIME type starting with 'audio/' (e.g., audio/mpeg, audio/wav).
  static bool _isAudio(String extension, String mime) => mime.startsWith('audio/');

  /// Tests if the MIME type or extension represents a video file.
  ///
  /// Matches MIME types starting with 'video/' or files with 'm3u8' extension
  /// (HLS streaming playlists).
  static bool _isVideo(String extension, String mime) => mime.startsWith('video/') || extension.contains('m3u8');

  /// Tests if the MIME type represents a document file.
  ///
  /// Supports a wide range of document formats including:
  /// - PDF documents
  /// - Microsoft Office files (Word, Excel, PowerPoint)
  /// - OpenDocument formats
  /// - Plain text and Markdown files
  /// - E-book formats (EPUB, MOBI, FictionBook)
  /// - Rich Text Format (RTF)
  /// - AbiWord documents
  static bool _isDocument(String extension, String mime) =>
      mime.startsWith('application/pdf') ||
      mime.startsWith('application/msword') ||
      mime.startsWith('application/vnd.openxmlformats-officedocument') ||
      mime.startsWith('application/vnd.ms-excel') ||
      mime.startsWith('application/vnd.ms-powerpoint') ||
      mime.startsWith('text/plain') ||
      mime.startsWith('application/rtf') ||
      mime.startsWith('application/vnd.oasis.opendocument') ||
      mime.startsWith('text/markdown') ||
      mime.startsWith('application/epub+zip') ||
      mime.startsWith('application/x-mobipocket-ebook') ||
      mime.startsWith('application/x-fictionbook+xml') ||
      mime.startsWith('application/x-abiword');

  /// Tests if the MIME type or extension represents an HTML file.
  ///
  /// Matches:
  /// - Standard HTML (text/html)
  /// - XHTML files (application/xhtml+xml)
  /// - URI lists (text/uri-list)
  /// - Common HTML extensions (html, htm, xhtml, xht)
  static bool _isHtml(String extension, String mime) =>
      mime.startsWith('text/html') ||
      mime.startsWith('application/xhtml') ||
      mime == 'text/uri-list' ||
      extension == 'html' ||
      extension == 'htm' ||
      extension == 'xhtml' ||
      extension == 'xht';

  /// Tests if the MIME type represents an archive/compressed file.
  ///
  /// Matches a wide variety of archive and compression formats including:
  /// - ZIP, RAR, 7-Zip
  /// - TAR archives (with or without compression)
  /// - GZIP, BZIP2, XZ compression
  /// - Legacy formats (StuffIt, ARJ, CAB, LZH, ACE, ARC)
  /// - Z-machine story files
  static bool _isArchive(String extension, String mime) =>
      mime.contains('zip') ||
      mime.contains('rar') ||
      mime.contains('tar') ||
      mime.contains('gzip') ||
      mime.contains('bzip') ||
      mime.contains('7z') ||
      mime.contains('xz') ||
      mime.contains('stuffit') ||
      mime.contains('arj') ||
      mime.contains('cab') ||
      mime.contains('lzh') ||
      mime.contains('ace') ||
      mime.contains('arc') ||
      mime.contains('zmachine');
}
