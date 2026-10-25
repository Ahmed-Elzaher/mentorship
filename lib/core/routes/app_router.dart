import 'package:flutter/material.dart';
import 'package:mentorship/core/routes/app_routes.dart';
import 'package:mentorship/features/auth/presentation/views/login_view.dart';
import 'package:mentorship/features/auth/presentation/views/register_view.dart';
import 'package:mentorship/features/auth/presentation/views/verify_email_view.dart';
import 'package:mentorship/features/products/data/models/product_models.dart';
import 'package:mentorship/features/products/presentation/screens/home_view.dart';
import 'package:mentorship/features/products/presentation/screens/product_details_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case AppRoutes.verifyEmail:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => VerifyEmailView(email: email),
        );

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case AppRoutes.productDetails:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(product: product),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
