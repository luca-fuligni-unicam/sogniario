class UploadedFile{
  final String? name;
  final int? bytes;

  const UploadedFile({
    required this.name,
    required this.bytes,
  });

  String get size {
    final kb = bytes! / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}