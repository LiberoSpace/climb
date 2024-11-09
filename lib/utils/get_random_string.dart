import 'dart:math';

String getRandomString(int len) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rnd = Random();
  String str = '';
  for (int i = 0; i < len; i++) {
    str += chars[rnd.nextInt(chars.length)];
  }
  return str;
}
