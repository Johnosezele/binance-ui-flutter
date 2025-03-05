import 'package:binanceui/core/theme/theme_provider.dart';
import 'package:binanceui/presentation/features/home/home_screen.dart';
import 'package:binanceui/presentation/features/home/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
    ChangeNotifierProvider(create: (_) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Remove splash screen when the app is ready
    FlutterNativeSplash.remove();
    
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
            return MaterialApp(
              title: 'Sisyphus',
              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,
              darkTheme: themeProvider.themeData,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: const HomeScreen(),
            );
          });
        });
  }
}
