import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomProvider=Provider((ref){
  final random=Random.secure();
  return random;
});

final randomStateProvider = StateProvider((ref) {
  return 0;
});