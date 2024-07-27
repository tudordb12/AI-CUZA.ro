import 'package:flutter_test/flutter_test.dart';
import 'package:aicuzaro/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CodeViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
