import 'dart:math';

int randomInRange(int start, int end) {
  final _random = new Random();
  return start + _random.nextInt(end - start);
}
