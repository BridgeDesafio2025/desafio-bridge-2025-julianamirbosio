import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import '../core/providers/favorites_provider.dart';
import '../core/app_export.dart';
import '../widgets/custom_error_widget.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(
      errorDetails: details,
    );
  };
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => FavoritesProvider(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'CineList',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // TO-DO: remover o tamanho da fonte estático
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.initial,
      );
    });
  }
}
