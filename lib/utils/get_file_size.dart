import 'dart:math';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

String formatBytesToMegaBytes(int bytes) {
  return '${(bytes / pow(1024, 2)).toStringAsFixed(2)}MB';
}

int getMegaByteByByte(int bytes) {
  return (bytes / pow(1024, 2)).ceil();
}
