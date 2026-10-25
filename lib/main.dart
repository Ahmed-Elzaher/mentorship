import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorship/core/routes/app_router.dart';
import 'package:mentorship/core/routes/app_routes.dart';
import 'package:mentorship/core/storage/token_storage.dart';
import 'package:mentorship/core/theme/app_colors.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mentorship/features/products/presentation/cubit/products_cubit.dart';
import 'package:mentorship/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenStorage.cachedAccessToken != null &&
        TokenStorage.cachedAccessToken!.isNotEmpty;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<ProductsCubit>(create: (_) => ProductsCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Lumina E-Commerce',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'), // الافتراضي إنجليزي مع دعم العربية تلقائياً
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: GoogleFonts.cairo().fontFamily,
              scaffoldBackgroundColor: AppColors.background,
              primaryColor: AppColors.primary,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                primary: AppColors.primary,
                surface: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
            ),
            initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
