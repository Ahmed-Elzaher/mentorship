import 'package:flutter_test/flutter_test.dart';
import 'package:mentorship/features/auth/presentation/views/login_view.dart';
import 'package:mentorship/main.dart';

void main() {
  testWidgets('App renders LoginView on initial launch when unauthenticated',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(LoginView), findsOneWidget);
    expect(find.text("Let's Sign You In"), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
