// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omilayer/omilayer.dart';

void main() {
  group('Omilayer', () {
    test('can be instantiated', () {
      expect(
          OmiLayer(
            buildContent: (context) => Text("Test"),
          ),
          isNotNull);
    });
  });
}
