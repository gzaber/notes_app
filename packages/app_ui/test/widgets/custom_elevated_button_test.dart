import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  group('CustomElevatedButton', () {
    testWidgets('renders widget passed as an argument', (tester) async {
      await tester.pumpTest(
        builder: (_) {
          return CustomElevatedButton(
            widget: const Icon(Icons.save),
            onPressed: () {},
          );
        },
      );

      expect(find.byIcon(Icons.save), findsOneWidget);
    });
  });
}
