import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:submission1/api/apiservice.dart';

void main() {
  test('ApiService.getRestaurn() bisa mendapatkan data dari internet, dan mengeluarkan hasil Map', () async {
   final hasil = await ApiService.getRestauran();
   
   expect(hasil['allRestauran'].isNotEmpty, true);
  });
}