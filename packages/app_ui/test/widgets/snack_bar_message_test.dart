import 'package:app_ui/app_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  group('SnackBarMessage', () {
    testWidgets('renders message', (tester) async {
      await tester.pumpTest(
        builder: (_) {
          return const SnackBarMessage(message: 'message');
        },
      );

      expect(find.text('message'), findsOneWidget);
    });
  });
}
